library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main_seven_segment_input is
    Port (clk: in std_logic;
          en: in std_logic;
          reset:in std_logic;
          bin: in std_logic_vector(13 downto 0);
          an: out std_logic_vector (3 downto 0);
          out_seven_seg: out std_logic_vector (6 downto 0));
end main_seven_segment_input;

architecture Behavioral of main_seven_segment_input is

signal LED_activating_counter1: std_logic_vector(1 downto 0);
--signal bin: std_logic_vector(27 downto 0) :="0101111000110000101001111000"; 

signal cod_digit_4th, cod_digit_3rd, cod_digit_2nd, cod_digit_1st : std_logic_vector (6 downto 0);

Component display_cntrl is
  Port (   clock_100Mhz : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
           reset : in STD_LOGIC;
           LED_activating_counter: out std_logic_vector(1 downto 0));
end COmponent;

Component bin_to_7seg_input is
 Port (bin: in std_logic_vector(13 downto 0);
       cod_digit_4th, cod_digit_3rd, cod_digit_2nd, cod_digit_1st : out std_logic_vector(6 downto 0));
       end Component;

component seven_segment_decoder_input is 
port(  en: in std_logic;
       an: out std_logic_vector (3 downto 0);
       cod_digit_4th, cod_digit_3rd, cod_digit_2nd, cod_digit_1st : in std_logic_vector(6 downto 0);
       LED_activating_counter:in std_logic_vector(1 downto 0);
       out_seven_seg: out std_logic_vector (6 downto 0));
end component;



begin

Udisplay_cntrl: display_cntrl PORT MAP(
                clock_100Mhz => clk,
                reset => reset,
                LED_activating_counter => LED_activating_counter1);
     
Ussd: bin_to_7seg_input port map ( 
                bin => bin,
                cod_digit_4th=>cod_digit_4th, cod_digit_3rd=>cod_digit_3rd, cod_digit_2nd=>cod_digit_2nd, cod_digit_1st=>cod_digit_1st); 

USEVEN_SEGMENT_DECODER : seven_segment_decoder_input PORT MAP(
                en=>en,
                an => an,
                cod_digit_4th=>cod_digit_4th, cod_digit_3rd=>cod_digit_3rd, cod_digit_2nd=>cod_digit_2nd, cod_digit_1st=>cod_digit_1st,
                LED_activating_counter => LED_activating_counter1,
                out_seven_seg => out_seven_seg
                );
                
end Behavioral;
