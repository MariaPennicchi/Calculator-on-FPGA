library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main_seven_segment is
    Port (clock_100Mhz: in std_logic;
          reset     :in std_logic;
          bin: in std_logic_vector(27 downto 0);
          neg: in std_logic; 
          y: in  std_logic ;
          dot: out std_logic;
          an: out std_logic_vector (3 downto 0);
          out_seven_seg: out std_logic_vector (6 downto 0);
          operator: in std_logic_vector(1 downto 0));
end main_seven_segment;

architecture Behavioral of main_seven_segment is

signal LED_activating_counter1: std_logic_vector(1 downto 0);
--signal bin: std_logic_vector(27 downto 0) :="0101111000110000101001111000"; 

signal display_number : std_logic_vector (55 downto 0);

Component display_cntrl is
  Port (   clock_100Mhz : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
           reset : in STD_LOGIC;
           LED_activating_counter: out std_logic_vector(1 downto 0));
end COmponent;

Component bin_to_7seg is
 Port (bin: in std_logic_vector(27 downto 0);
       display_number :out std_logic_vector( 55 downto 0));
       end Component;

component seven_segment_decoder is 
port(      neg: in std_logic;
           y:   in  std_logic ;
           dot: out std_logic;
           an: out std_logic_vector (3 downto 0);
           display_number :in std_logic_vector( 55 downto 0);
           LED_activating_counter:in std_logic_vector(1 downto 0);
           out_seven_seg: out std_logic_vector (6 downto 0);
           operator: in std_logic_vector(1 downto 0));
end component;



begin

Udisplay_cntrl: display_cntrl PORT MAP(
                clock_100Mhz => clock_100Mhz,
                reset => reset,
                LED_activating_counter => LED_activating_counter1);
     
Ussd: bin_to_7seg port map ( 
                bin => bin,
                display_number => display_number); 
USEVEN_SEGMENT_DECODER : seven_segment_decoder PORT MAP(
                neg=>neg, 
                y => y,
                dot => dot,
                an => an,
                display_number => display_number,
                LED_activating_counter => LED_activating_counter1,
                out_seven_seg => out_seven_seg,
                operator => operator
                );

end Behavioral;
