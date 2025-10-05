library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divisore_binario is
    Port (  clk: in std_logic; 
            num  : in  std_logic_vector(15 downto 0) := (others => '0');  -- Numero da dividere
            den   : in  std_logic_vector(15 downto 0):= (others => '0');  -- Divisore
            q  : out std_logic_vector(15 downto 0):= (others => '0');  -- Quoziente
            remainder : out std_logic_vector(15 downto 0):= (others => '0') -- Resto
            ); 
end divisore_binario;

architecture Behavioral of divisore_binario is
signal q_temp_sig, rem_temp_sig: std_logic_vector(15 downto 0):= (others => '0');
begin

process(num, den, clk)
    variable start_bit_den, start_bit_num, end_bit_q, next_bit, sn, sd: integer :=15;
    variable len_temp_num, j, t, h, k, index: integer:=0;
    variable temp_num, temp_q, q_var, num1, den1: std_logic_vector(15 downto 0) := (others => '0');  
    variable i, temp_reset: std_logic :='0';
    variable temp_prod: unsigned(31 downto 0);
    
    begin
    
    if rising_edge(clk) then 
        
        start_bit_den:=15;
        start_bit_num:=15;
        end_bit_q:=15;
        next_bit:=15;
        sn:=15;
        sd:=15;
        len_temp_num:=0;
        j:=0;
        t:=0;
        h:=0;
        k:=0;
        index:=0;
        temp_num:=(others => '0');
        temp_q:=(others => '0');
        q_var:=(others => '0');
        i:='0';
        
        num1:=num;
        den1:=den;
                  
            for start_bit_den in 15 downto 0 loop
                i:= den1(start_bit_den);
                sd:=start_bit_den;
                exit when i='1'; 
            end loop;
            
            for start_bit_num in 15 downto 0 loop 
                i:=num1(start_bit_num);
                sn:= start_bit_num;
                exit when i='1'; 
            end loop;
            
            if(sn>=sd) then 
                next_bit:=sn - sd;    
        
                
                for j in 15 downto 0 loop
                    temp_num(j):='0';
                    exit when j<=sd+1;
                end loop;
                for j in 0 to 15 loop
                    index:=next_bit+j;
                    temp_num(j):=num1(index);  
                    exit when j=sd;
                end loop;  
                
                for j in 15 downto 0 loop
                    i:=temp_num(j);
                    t:=j;
                    exit when i='1';
                end loop;
                len_temp_num := t; --lunghezza scalata di uno (come tutte le altre, così sono confrontabili)
            
                for k in 15 downto 0 loop   --trovo quoziente intero
                   if unsigned(temp_num)>=unsigned(den1) then 
                       temp_q(k):='1';    
                       temp_num := std_logic_vector(unsigned(temp_num) - unsigned(den1)); --signed converte l'argomento in un vettore binario, std_logic_vector lo riconverte in std_logic
                       
                       for j in 15 downto 0 loop
                           i:=temp_num(j);
                           t:=j;
                           exit when i='1';
                       end loop;
                       len_temp_num := t; 
                    else
                        temp_q(k):='0';    
                    end if;
                    
                    next_bit:=next_bit-1;
                    
                    if len_temp_num<15 and next_bit>=0 then 
                        for j in 15 downto 1 loop
                            temp_num(j):=temp_num(j-1);  
                        end loop;
                        temp_num(0):=num1(next_bit);           
                        len_temp_num:=len_temp_num+1;
                    end if;
                   
                    end_bit_q:=k-1;
                   
                    exit when next_bit<0;
                end loop;
                
                for index in 15 downto 0 loop
                    k:=index-end_bit_q-1;
                    q_var(k):=temp_q(index);   
                    j:= end_bit_q+1;
                    exit when index=j;
                end loop;
            else
                q_var:=(others=>'0');
            end if; 
            
            q_temp_sig<=q_var; 
            
            temp_prod:= unsigned(den1) * unsigned(q_var);
            rem_temp_sig <= std_logic_vector(unsigned(num1) - temp_prod(15 downto 0));
            
    end if;    
end process;

q<=q_temp_sig;
remainder<=rem_temp_sig;

end Behavioral;
