----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2023 14:47:39
-- Design Name: 
-- Module Name: moltiplicatore - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity moltiplicatore is
 Port ( 
        n1     : in  std_logic_vector ( 13 downto 0) := (others => '0');
        n2     : in  std_logic_vector ( 13 downto 0) := (others => '0');
        reset  : in  std_logic;
        uscita : out std_logic_vector ( 27 downto 0) := (others => '0')
 );
end moltiplicatore;


architecture Behavioral of moltiplicatore is
-- cettori dei and parziali
signal x0 ,x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13 : std_logic_vector (13 downto 0) := (others => '0');
-- vettori somme parziali per righe
signal s0 , s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12 : std_logic_vector (13 downto 0) := (others => '0');
-- vettori carry parziali per righe
signal c0 , c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12 : std_logic_vector (13 downto 0) := (others => '0');

component full_adder port(
            a,b,cin :in std_logic;
            cout,s :out std_logic
);
end component full_adder;
signal n11, n22 :std_logic_vector ( 13 downto 0);

begin
n11 <= n1;
n22 <= n2;
    process (n11,n22, reset)

        --variable k : integer := 0;
        
       begin

       for k in 0 to 13 loop
            x0(k)  <= n11(k) and n22(0);
            x1(k)  <= n11(k) and n22(1);
            x2(k)  <= n11(k) and n22(2);
            x3(k)  <= n11(k) and n22(3);
            x4(k)  <= n11(k) and n22(4);
            x5(k)  <= n11(k) and n22(5);
            x6(k)  <= n11(k) and n22(6);
            x7(k)  <= n11(k) and n22(7);
            x8(k)  <= n11(k) and n22(8);
            x9(k)  <= n11(k) and n22(9);
            x10(k) <= n11(k) and n22(10);
            x11(k) <= n11(k) and n22(11);
            x12(k) <= n11(k) and n22(12);
            x13(k) <= n11(k) and n22(13);
            
         end loop;
    end process;
    
    u0 : full_adder port map(a => x0(1) , b => x1(0) , cin => '0' , cout => c0(0), s => s0(0) );
    
    somma_parziale1 : for i in 1 to 12  generate
        u : full_adder port map( a => x0(i+1) , 
                                     b => x1(i) , 
                                     cin => c0(i-1) , 
                                     cout => c0(i), 
                                     s => s0(i) 
                                    );
    end generate somma_parziale1;
    -- ultimo sommatore parziale prima riga
    u2 : full_adder port map(a => '0' , b => x1(13) , cin => c0(12) , cout => c0(13), s => s0(13) );
    
    
    u3 : full_adder port map(a => x2(0) , b => s0(1) , cin => '0' , cout => c1(0), s => s1(0) );
    
    somma_parziale2 : for i in 1 to 12  generate
        u : full_adder port map( a => x2(i) , 
                                     b => s0(i+1) , 
                                     cin => c1(i-1) , 
                                     cout => c1(i), 
                                     s => s1(i) 
                                    );
    end generate somma_parziale2;
    -- ultimo sommatore parziale seconda riga
    u4 : full_adder port map(a => c0(13) , b => x2(13) , cin => c1(12) , cout => c1(13), s => s1(13) );
    --------------------------------------------------------------------------------------------------------------
    
    u5 : full_adder port map(a => x3(0) , b => s1(1) , cin => '0' , cout => c2(0), s => s2(0) );
    
    somma_parziale3 : for i in 1 to 12  generate
        u : full_adder port map( a => x3(i) , 
                                     b => s1(i+1) , 
                                     cin => c2(i-1) , 
                                     cout => c2(i), 
                                     s => s2(i) 
                                    );
    end generate somma_parziale3;
    -- ultimo sommatore parziale terza riga
    u6 : full_adder port map(a => c1(13) , b => x3(13) , cin => c2(12) , cout => c2(13), s => s2(13) );
    
    ---------------------------------------------------------------------------------------------------------------
    ----4° riga di somme parziali   
    u7 : full_adder port map(a => x4(0) , b => s2(1) , cin => '0' , cout => c3(0), s => s3(0) );
    
    somma_parziale4 : for i in 1 to 12  generate
        u : full_adder port map( a => x4(i) , 
                                     b => s2(i+1) , 
                                     cin => c3(i-1) , 
                                     cout => c3(i), 
                                     s => s3(i) 
                                    );
    end generate somma_parziale4;
    -- ultimo sommatore parziale quarta riga
    u8 : full_adder port map(a => c2(13) , b => x4(13) , cin => c3(12) , cout => c3(13), s => s3(13) );
    
    ---------------------------------------------------------------------------------------------------------------
    ----5° riga di somme parziali   
    u9 : full_adder port map(a => x5(0) , b => s3(1) , cin => '0' , cout => c4(0), s => s4(0) );
    
    somma_parziale5 : for i in 1 to 12  generate
        u : full_adder port map( a => x5(i) , 
                                     b => s3(i+1) , 
                                     cin => c4(i-1) , 
                                     cout => c4(i), 
                                     s => s4(i) 
                                    );
    end generate somma_parziale5;
    -- ultimo sommatore parziale quinta riga
    u10 : full_adder port map(a => c3(13) , b => x5(13) , cin => c4(12) , cout => c4(13), s => s4(13) );
    
    ---------------------------------------------------------------------------------------------------------------
    
    ----6° riga di somme parziali   
    u11 : full_adder port map(a => x6(0) , b => s4(1) , cin => '0' , cout => c5(0), s => s5(0) );
    
    somma_parziale6 : for i in 1 to 12  generate
        u : full_adder port map( a => x6(i) , 
                                     b => s4(i+1) , 
                                     cin => c5(i-1) , 
                                     cout => c5(i), 
                                     s => s5(i) 
                                    );
    end generate somma_parziale6;
    -- ultimo sommatore parziale sesta riga
    u12 : full_adder port map(a => c4(13) , b => x6(13) , cin => c5(12) , cout => c5(13), s => s5(13) );
    
    ---------------------------------------------------------------------------------------------------------------
    
    ----7° riga di somme parziali   
    u13 : full_adder port map(a => x7(0) , b => s5(1) , cin => '0' , cout => c6(0), s => s6(0) );
    
    somma_parziale7 : for i in 1 to 12  generate
        u : full_adder port map( a => x7(i) , 
                                     b => s5(i+1) , 
                                     cin => c6(i-1) , 
                                     cout => c6(i), 
                                     s => s6(i) 
                                    );
    end generate somma_parziale7;
    -- ultimo sommatore parziale settima riga
    u14 : full_adder port map(a => c5(13) , b => x7(13) , cin => c6(12) , cout => c6(13), s => s6(13) );
    
    ---------------------------------------------------------------------------------------------------------------
     
    ----8° riga di somme parziali   
    u15 : full_adder port map(a => x8(0) , b => s6(1) , cin => '0' , cout => c7(0), s => s7(0) );
    
    somma_parziale8 : for i in 1 to 12  generate
        u : full_adder port map( a => x8(i) , 
                                     b => s6(i+1) , 
                                     cin => c7(i-1) , 
                                     cout => c7(i), 
                                     s => s7(i) 
                                    );
    end generate somma_parziale8;
    -- ultimo sommatore parziale ottava riga
    u16 : full_adder port map(a => c6(13) , b => x8(13) , cin => c7(12) , cout => c7(13), s => s7(13) );
    
    ---------------------------------------------------------------------------------------------------------------
     
    ----9° riga di somme parziali   
    u17 : full_adder port map(a => x9(0) , b => s7(1) , cin => '0' , cout => c8(0), s => s8(0) );
    
    somma_parziale9 : for i in 1 to 12  generate
        u : full_adder port map( a => x9(i) , 
                                     b => s7(i+1) , 
                                     cin => c8(i-1) , 
                                     cout => c8(i), 
                                     s => s8(i) 
                                    );
    end generate somma_parziale9;
    -- ultimo sommatore parziale nona riga
    u18 : full_adder port map(a => c7(13) , b => x9(13) , cin => c8(12) , cout => c8(13), s => s8(13) );
    
    ---------------------------------------------------------------------------------------------------------------
     
    ----10° riga di somme parziali   
    u19 : full_adder port map(a => x10(0) , b => s8(1) , cin => '0' , cout => c9(0), s => s9(0) );
    
    somma_parziale10 : for i in 1 to 12  generate
        u : full_adder port map( a => x10(i) , 
                                     b => s8(i+1) , 
                                     cin => c9(i-1) , 
                                     cout => c9(i), 
                                     s => s9(i) 
                                    );
    end generate somma_parziale10;
    -- ultimo sommatore parziale decima riga
    u20 : full_adder port map(a => c8(13) , b => x10(13) , cin => c9(12) , cout => c9(13), s => s9(13) );
    
    ---------------------------------------------------------------------------------------------------------------
     
    ----11° riga di somme parziali   
    u21 : full_adder port map(a => x11(0) , b => s9(1) , cin => '0' , cout => c10(0), s => s10(0) );
    
    somma_parziale11 : for i in 1 to 12  generate
        u : full_adder port map( a => x11(i) , 
                                     b => s9(i+1) , 
                                     cin => c10(i-1) , 
                                     cout => c10(i), 
                                     s => s10(i) 
                                    );
    end generate somma_parziale11;
    -- ultimo sommatore parziale undicesima riga
    u22 : full_adder port map(a => c9(13) , b => x11(13) , cin => c10(12) , cout => c10(13), s => s10(13) );
    
    ---------------------------------------------------------------------------------------------------------------
     
    ----12° riga di somme parziali   
    u23 : full_adder port map(a => x12(0) , b => s10(1) , cin => '0' , cout => c11(0), s => s11(0) );
    
    somma_parziale12 : for i in 1 to 12  generate
        u : full_adder port map( a => x12(i) , 
                                     b => s10(i+1) , 
                                     cin => c11(i-1) , 
                                     cout => c11(i), 
                                     s => s11(i) 
                                    );
    end generate somma_parziale12;
    -- ultimo sommatore parziale dodicesima riga
    u24 : full_adder port map(a => c10(13) , b => x12(13) , cin => c11(12) , cout => c11(13), s => s11(13) );
    
    ---------------------------------------------------------------------------------------------------------------
     
    ----13° riga di somme parziali   
    u25 : full_adder port map(a => x13(0) , b => s11(1) , cin => '0' , cout => c12(0), s => s12(0) );
    
    somma_parziale13 : for i in 1 to 12  generate
        u : full_adder port map( a => x13(i) , 
                                     b => s11(i+1) , 
                                     cin => c12(i-1) , 
                                     cout => c12(i), 
                                     s => s12(i) 
                                    );
    end generate somma_parziale13;
    -- ultimo sommatore parziale tredicesima riga
    u26 : full_adder port map(a => c11(13) , b => x13(13) , cin => c12(12) , cout => c12(13), s => s12(13) );
    
    ---------------------------------------------------------------------------------------------------------------
    uscita(0)  <= x0(0);
    uscita(1)  <= s0(0);
    uscita(2)  <= s1(0);
    uscita(3)  <= s2(0);
    uscita(4)  <= s3(0);
    uscita(5)  <= s4(0);
    uscita(6)  <= s5(0);
    uscita(7)  <= s6(0);
    uscita(8)  <= s7(0);
    uscita(9)  <= s8(0);
    uscita(10) <= s9(0);
    uscita(11) <= s10(0);
    uscita(12) <= s11(0);
    
    uscita(13)  <= s12(0);
    uscita(14)  <= s12(1);
    uscita(15)  <= s12(2);
    uscita(16)  <= s12(3);
    uscita(17)  <= s12(4);
    uscita(18)  <= s12(5);
    uscita(19)  <= s12(6);
    uscita(20)  <= s12(7);
    uscita(21)  <= s12(8);
    uscita(22)  <= s12(9);
    uscita(23)  <= s12(10);
    uscita(24)  <= s12(11);
    uscita(25)  <= s12(12);
    uscita(26)  <= s12(13);

    uscita(27) <= c12(13);
    
   
 
    
end Behavioral;
