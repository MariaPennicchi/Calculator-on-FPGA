library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;

entity seven_segment_decoder_input is
    Port ( en: in std_logic :='1';
           an: out std_logic_vector (3 downto 0);
           cod_digit_4th, cod_digit_3rd, cod_digit_2nd, cod_digit_1st : in std_logic_vector(6 downto 0);
           LED_activating_counter:in std_logic_vector(1 downto 0);
           out_seven_seg: out std_logic_vector (6 downto 0)
         );
end seven_segment_decoder_input;

architecture Behavioral of seven_segment_decoder_input is
SIGNAL an1 : std_logic_vector (3 downto 0);
signal out_seven_seg1:  std_logic_vector (6 downto 0);

begin

process (LED_activating_counter, en, cod_digit_4th, cod_digit_3rd, cod_digit_2nd, cod_digit_1st)

begin
    if en='1' then
        case LED_activating_counter is 
            when "00" => 
                  out_seven_seg1 <= cod_digit_4th;
                  an1 <= "0111";
            when "01" =>
                  out_seven_seg1 <= cod_digit_3rd;
                  an1 <= "1011";
            when "10" =>
                  out_seven_seg1 <= cod_digit_2nd;
                  an1 <= "1101";
            when "11" =>
                  out_seven_seg1 <= cod_digit_1st;
                  an1 <= "1110";
            when others =>
                  out_seven_seg1 <= "1111111";
                  an1 <= "1111";
        end case;
    else
        out_seven_seg1 <= "1111111";
        an1 <= "1111";
    end if;
end process;
out_seven_seg <= out_seven_seg1;
an <= an1;
end Behavioral;
