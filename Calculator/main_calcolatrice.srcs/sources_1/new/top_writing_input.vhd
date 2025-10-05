library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_writing_input is 
    Port (clk: in std_logic;
          swt_num: in std_logic_vector(9 downto 0);
          swt_op: in std_logic_vector(3 downto 0);
          swt_eq: in std_logic;
          btn_reset: in std_logic;
          bin1, bin2: out std_logic_vector(13 downto 0):=(others=>'0');
          operator: out std_logic_vector(1 downto 0);
          an: out std_logic_vector(3 downto 0); 
          out_seven_seg: out std_logic_vector (6 downto 0);
          finished_reading: out std_logic
          );
end top_writing_input;

architecture Behavioral of top_writing_input is
component read_input is
    Port (clk: in std_logic;
          swt_num: in std_logic_vector(9 downto 0);
          swt_op: in std_logic_vector(3 downto 0);
          swt_eq: in std_logic;
          btn_reset: in std_logic;
          digit1: out std_logic_vector(15 downto 0) := (others=>'0');
          digit2: out std_logic_vector(15 downto 0) := (others=>'0');
          operator: out std_logic_vector(1 downto 0);
          finished_reading: out std_logic :='0';
          reset: out std_logic:='0';
          end_first_num, end_second_num: out std_logic :='0'
          );
end component read_input;

component main_seven_segment_input is
    Port (clk: in std_logic;
          en: in std_logic;
          reset:in std_logic;
          bin: in std_logic_vector(13 downto 0);
          an: out std_logic_vector (3 downto 0);
          out_seven_seg: out std_logic_vector (6 downto 0));
end component main_seven_segment_input;

signal digit_exa1, digit_exa2: std_logic_vector(15 downto 0) := (others=>'0');
signal temp_finished_reading, reset, end_first_num, end_second_num: std_logic :='0';
signal temp, temp_bin1, temp_bin2: std_logic_vector(13 downto 0):=(others=>'0'); 
signal temp_operator: std_logic_vector(1 downto 0);
signal en:std_logic :='1';

begin

ri: read_input port map (clk => clk, swt_num=>swt_num, swt_op=>swt_op, swt_eq=>swt_eq, btn_reset=>btn_reset, digit1=>digit_exa1, digit2=>digit_exa2, operator=>temp_operator, finished_reading=>temp_finished_reading, reset=>reset, end_first_num=>end_first_num, end_second_num=>end_second_num); 

exa2bin: process(clk, temp_finished_reading, digit_exa1, digit_exa2)
variable i: integer :=0;
constant one: std_logic_vector(9 downto 0):="0000000001";
constant ten: std_logic_vector(9 downto 0):="0000001010";
constant hundred: std_logic_vector(9 downto 0):="0001100100";
constant thousand: std_logic_vector(9 downto 0):="1111101000";
begin

temp_bin1<=std_logic_vector((unsigned(digit_exa1(3 downto 0))*unsigned(one))+ (unsigned(digit_exa1(7 downto 4))*unsigned(ten))+(unsigned(digit_exa1(11 downto 8))*unsigned(hundred))+(unsigned(digit_exa1(15 downto 12))*unsigned(thousand)));
temp_bin2<=std_logic_vector((unsigned(digit_exa2(3 downto 0))*unsigned(one))+ (unsigned(digit_exa2(7 downto 4))*unsigned(ten))+(unsigned(digit_exa2(11 downto 8))*unsigned(hundred))+(unsigned(digit_exa2(15 downto 12))*unsigned(thousand)));

end process;

mssi: main_seven_segment_input port map(en=>en, clk=>clk, reset=>reset, bin=>temp, an=>an, out_seven_seg=>out_seven_seg); --cambia codice qui dentro

var_temp: process(clk, temp_operator, end_first_num, end_second_num, temp_finished_reading, temp_bin1, temp_bin2)
begin
    if end_first_num='0' then
        temp<=temp_bin1;
    elsif end_first_num='1' and end_second_num='0' then 
        temp<=temp_bin2;
    else
        temp<="00000000000000";
    end if;
    
    if temp_finished_reading='1' then
        en<='0';
    end if;
    
    if btn_reset='1' then
        en<='1';
    end if;
end process;

bin1<=temp_bin1;
bin2<=temp_bin2;
operator<=temp_operator;
finished_reading<=temp_finished_reading;

end Behavioral;
