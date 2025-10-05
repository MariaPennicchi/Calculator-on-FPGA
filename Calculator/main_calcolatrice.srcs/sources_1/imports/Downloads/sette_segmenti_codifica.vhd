library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;

entity seven_segment_decoder is
    Port ( neg: in std_logic;
           y: in  std_logic :='0';
           dot: out std_logic;
           an: out std_logic_vector (3 downto 0);
           display_number : in std_logic_vector (55 downto 0);
           LED_activating_counter:in std_logic_vector(1 downto 0);
           out_seven_seg: out std_logic_vector (6 downto 0);
           operator: in std_logic_vector(1 downto 0)
         );
end seven_segment_decoder;

architecture Behavioral of seven_segment_decoder is
SIGNAL an1 : std_logic_vector (3 downto 0);
signal out_seven_seg1:  std_logic_vector (6 downto 0);
signal cod_digit_8th, cod_digit_7th, cod_digit_6th, cod_digit_5th, cod_digit_4th, cod_digit_3rd, cod_digit_2nd, cod_digit_1st : std_logic_vector(6 downto 0);


begin

cod_digit_8th <= display_number (55 downto 49);
cod_digit_7th <= display_number (48 downto 42);
cod_digit_6th <= display_number (41 downto 35);
cod_digit_5th <= display_number (34 downto 28);
cod_digit_4th <= display_number (27 downto 21);
cod_digit_3rd <= display_number (20 downto 14);
cod_digit_2nd <= display_number (13 downto 7);
cod_digit_1st <= display_number (6 downto 0);

process (LED_activating_counter)

begin

    if y = '1' then
        case LED_activating_counter is 
            when "00" => 
                  if neg='1' and operator="11" then
                      out_seven_seg1 <= "0111111";
                  else
                      out_seven_seg1 <= cod_digit_8th;
                  end if;
                  an1 <= "0111";
                  dot <= '1';
            when "01" =>
                  out_seven_seg1 <= cod_digit_7th;
                  an1 <= "1011";
                  dot <= '1';
            when "10" =>
                  out_seven_seg1 <= cod_digit_6th;
                  an1 <= "1101";
                  dot <= '1';
            when "11" =>
                  out_seven_seg1 <= cod_digit_5th;
                  an1 <= "1110";
                  dot <= '0';    
--            when others =>
--                  out_seven_seg1 <= "1111111";
--                  an1 <= "1111";
--                  dot <= '0';
        end case;
        
    elsif y = '0' then
        case LED_activating_counter is 
            when "00" => 
                  out_seven_seg1 <= cod_digit_4th;
                  dot <= '0';
                  an1 <= "0111";
            when "01" =>
                  out_seven_seg1 <= cod_digit_3rd;
                  dot <= '1';
                  an1 <= "1011";
            when "10" =>
                  out_seven_seg1 <= cod_digit_2nd;
                  dot <= '1';
                  an1 <= "1101";
            when "11" =>
                  out_seven_seg1 <= cod_digit_1st;
                  dot <= '1';
                  an1 <= "1110";
--            when others =>
--                  out_seven_seg1 <= "1111111";
--                  an1 <= "1111";
--                  dot <= '0';
        end case;
   end if;

end process;
out_seven_seg <= out_seven_seg1;
an <= an1;
end Behavioral;
