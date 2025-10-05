library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity read_input is
    Port (clk: in std_logic;
          swt_num: in std_logic_vector(9 downto 0);
          swt_op: in std_logic_vector(3 downto 0);
          swt_eq: in std_logic;
          btn_reset: in std_logic:='0';
          --btn_enter: in std_logic;
          digit1: out std_logic_vector(15 downto 0) := (others=>'0');
          digit2: out std_logic_vector(15 downto 0) := (others=>'0');
          operator: out std_logic_vector(1 downto 0);
          finished_reading: out std_logic :='0';
          reset: out std_logic:='0';
          end_first_num, end_second_num: out std_logic :='0'
          );
end read_input;

architecture Behavioral of read_input is

signal index1, index2: integer:=0;


begin

read: process(clk, swt_num, swt_op, swt_eq, btn_reset, index1, index2) --, btn_enter)
variable temp_index1, temp_index2: integer :=0;
variable temp_end_first_num, temp_end_second_num, temp_finished_reading, temp_reset: std_logic :='0';
variable digit_int1, digit_int2: std_logic_vector(15 downto 0):=(others=>'0');
variable temp_operator: std_logic_vector(1 downto 0);
variable ctrl1, ctrl2: std_logic :='0';
--variable temp_btn_enter: std_logic;
begin
if rising_edge(clk) then
    
    temp_index1:=index1;
    temp_index2:=index2;
--    temp_btn_enter:=btn_enter;
    
    if temp_index1<4 and temp_end_first_num='0' and btn_reset='0' and ctrl1='0' then --and temp_btn_enter='1' then
        if swt_num="0000000001" then
            digit_int1(4*temp_index1+3 downto 4*temp_index1) := x"0";
            ctrl1:='1';
            --temp_index1:=temp_index1+1;
            --temp_btn_enter:='0';
        elsif swt_num="0000000010" then
            digit_int1(4*temp_index1+3 downto 4*temp_index1) := x"1";
            ctrl1:='1';
            --temp_index1:=temp_index1+1;
            --temp_btn_enter:='0';
        elsif swt_num="0000000100" then
            digit_int1(4*temp_index1+3 downto 4*temp_index1) := x"2";
            ctrl1:='1';
            --temp_index1:=temp_index1+1;
            --temp_btn_enter:='0';
        elsif swt_num="0000001000" then
            digit_int1(4*temp_index1+3 downto 4*temp_index1) := x"3";
            ctrl1:='1';
            --temp_index1:=temp_index1+1;
            --temp_btn_enter:='0';
        elsif swt_num="0000010000" then
            digit_int1(4*temp_index1+3 downto 4*temp_index1) := x"4";
            ctrl1:='1';
            --temp_index1:=temp_index1+1;
            --temp_btn_enter:='0';
        elsif swt_num="0000100000" then
            digit_int1(4*temp_index1+3 downto 4*temp_index1) := x"5";
            ctrl1:='1';
            --temp_index1:=temp_index1+1;
            --temp_btn_enter:='0';
        elsif swt_num="0001000000" then
            digit_int1(4*temp_index1+3 downto 4*temp_index1) := x"6";
            ctrl1:='1';
            --temp_index1:=temp_index1+1;
            --temp_btn_enter:='0';
        elsif swt_num="0010000000" then
            digit_int1(4*temp_index1+3 downto 4*temp_index1) := x"7";
            ctrl1:='1';
            --temp_index1:=temp_index1+1;
            --temp_btn_enter:='0';
        elsif swt_num="0100000000" then
            digit_int1(4*temp_index1+3 downto 4*temp_index1) := x"8";
            ctrl1:='1';
            --temp_index1:=temp_index1+1;
            --temp_btn_enter:='0';
        elsif swt_num="1000000000" then
            digit_int1(4*temp_index1+3 downto 4*temp_index1) := x"9";
            ctrl1:='1';
            --temp_index1:=temp_index1+1;
            --temp_btn_enter:='0';
        end if;
        
        if(index1=1) then
        temp_reset:='0';
        end if;
        
    end if;
    
    if swt_num="0000000000" and temp_index1<4 and ctrl1='1'then
        temp_index1:=temp_index1+1;
        ctrl1:='0';
    end if;
    
    if temp_end_first_num='0' and btn_reset='0' then --and temp_btn_enter='1' then
        if swt_op="0001" then
            temp_operator:= "00"; -- + 
            temp_end_first_num:='1';
            --temp_btn_enter:='0';
        elsif swt_op="0010" then
            temp_operator:= "01"; -- *
            temp_end_first_num:='1';
            --temp_btn_enter:='0';
        elsif swt_op="0100" then
            temp_operator:= "10"; -- /
            temp_end_first_num:='1';
            --temp_btn_enter:='0';
        elsif swt_op="1000" then
            temp_operator:= "11"; -- -
            temp_end_first_num:='1';
            --temp_btn_enter:='0';
        end if;
    end if;
    
    if temp_index2<4 and temp_end_second_num='0'and temp_end_first_num='1' and btn_reset='0' and ctrl2='0' then --and temp_btn_enter='1' then
        if swt_num="0000000001" then
            digit_int2(4*temp_index2+3 downto 4*temp_index2) := x"0";
            ctrl2:='1';
            --temp_index2:=temp_index2+1;
            --temp_btn_enter:='0';
        elsif swt_num="0000000010" then
            digit_int2(4*temp_index2+3 downto 4*temp_index2) := x"1";
            ctrl2:='1';
            --temp_index2:=temp_index2+1;
            --temp_btn_enter:='0';
        elsif swt_num="0000000100" then
            digit_int2(4*temp_index2+3 downto 4*temp_index2) := x"2";
            ctrl2:='1';
            --temp_index2:=temp_index2+1;
            --temp_btn_enter:='0';
        elsif swt_num="0000001000" then
            digit_int2(4*temp_index2+3 downto 4*temp_index2) := x"3";
            ctrl2:='1';
            --temp_index2:=temp_index2+1;
            --temp_btn_enter:='0';
        elsif swt_num="0000010000" then
            digit_int2(4*temp_index2+3 downto 4*temp_index2) := x"4";
            ctrl2:='1';
            --temp_index2:=temp_index2+1;
            --temp_btn_enter:='0';
        elsif swt_num="0000100000" then
            digit_int2(4*temp_index2+3 downto 4*temp_index2) := x"5";
            ctrl2:='1';
            --temp_index2:=temp_index2+1;
            --temp_btn_enter:='0';
        elsif swt_num="0001000000" then
            digit_int2(4*temp_index2+3 downto 4*temp_index2) := x"6";
            ctrl2:='1';
            --temp_index2:=temp_index2+1;
            --temp_btn_enter:='0';
        elsif swt_num="0010000000" then
            digit_int2(4*temp_index2+3 downto 4*temp_index2) := x"7";
            ctrl2:='1';
            --temp_index2:=temp_index2+1;
            --temp_btn_enter:='0';
        elsif swt_num="0100000000" then
            digit_int2(4*temp_index2+3 downto 4*temp_index2) := x"8";
            ctrl2:='1';
            --temp_index2:=temp_index2+1;
            --temp_btn_enter:='0';
        elsif swt_num="1000000000" then
            digit_int2(4*temp_index2+3 downto 4*temp_index2) := x"9";
            ctrl2:='1';
            --temp_index2:=temp_index2+1;
            --temp_btn_enter:='0';
        end if;
    end if;
    
    if swt_num="0000000000" and temp_index2<4 and ctrl2='1' then
        temp_index2:=temp_index2+1;
        ctrl2:='0';
    end if;
    
    if temp_end_second_num='0' and temp_end_first_num='1' and btn_reset='0' and not(temp_operator= "10" and digit_int2="0000000000000000") then --and temp_btn_enter='1' then
        if swt_eq='1' then
            temp_finished_reading := '1'; -- = 
            temp_end_second_num:='1';
            --temp_btn_enter:='0';
        end if;
    end if;
    
    if btn_reset='1' then -- canc (reset)
         digit_int1:= (others=>'0');
         digit_int2:= (others=>'0');
         temp_finished_reading:='0';
         temp_index1:=0;
         temp_index2:=0;
         temp_end_first_num:='0';
         temp_end_second_num:='0';
         temp_reset:='1';
         ctrl1:='0';
         ctrl2:='0';
         temp_operator:="00";
    end if;
end if;
    index1<=temp_index1;
    index2<=temp_index2;
    end_first_num<=temp_end_first_num; 
    end_second_num<=temp_end_second_num;
    reset<=temp_reset;
    finished_reading<=temp_finished_reading;
    digit1<=digit_int1;
    digit2<=digit_int2;
    operator<=temp_operator;

end process;

end Behavioral;
