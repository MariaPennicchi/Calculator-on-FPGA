library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bin_to_7seg_input is
    Port (bin: in std_logic_vector(13 downto 0);
          cod_digit_4th, cod_digit_3rd, cod_digit_2nd, cod_digit_1st : out std_logic_vector(6 downto 0)
          );
end bin_to_7seg_input;

architecture Behavioral of bin_to_7seg_input is
          
begin

process (bin)
variable int: integer;
variable digit_4th, digit_3rd, digit_2nd, digit_1st : integer range 0 to 9;
variable mod_digit_4th, mod_digit_3rd, mod_digit_2nd: integer := 0;

begin
int := to_integer(unsigned(bin)); 

mod_digit_4th := int mod 1000; 
digit_4th := (int - mod_digit_4th )/1000; 

mod_digit_3rd := mod_digit_4th mod 100; 
digit_3rd := (mod_digit_4th - mod_digit_3rd)/100; 

mod_digit_2nd := mod_digit_3rd mod 10;
digit_2nd := (mod_digit_3rd - mod_digit_2nd)/10;

digit_1st := mod_digit_2nd; 

case digit_4th is
     when 9 => cod_digit_4th <= "0010000";
     when 8 => cod_digit_4th <= "0000000";
     when 7 => cod_digit_4th <= "1111000";
     when 6 => cod_digit_4th <= "0000010";
     when 5 => cod_digit_4th <= "0010010";
     when 4 => cod_digit_4th <= "0011001";
     when 3 => cod_digit_4th <= "0110000";
     when 2 => cod_digit_4th <= "0100100";
     when 1 => cod_digit_4th <= "1111001";
     when 0 => cod_digit_4th <= "1000000";
end case;

case digit_3rd is
     when 9 => cod_digit_3rd <= "0010000";
     when 8 => cod_digit_3rd <= "0000000";
     when 7 => cod_digit_3rd <= "1111000";
     when 6 => cod_digit_3rd <= "0000010";
     when 5 => cod_digit_3rd <= "0010010";
     when 4 => cod_digit_3rd <= "0011001";
     when 3 => cod_digit_3rd <= "0110000";
     when 2 => cod_digit_3rd <= "0100100";
     when 1 => cod_digit_3rd <= "1111001";
     when 0 => cod_digit_3rd <= "1000000";
end case;
     
case digit_2nd is
     when 9 => cod_digit_2nd <= "0010000";
     when 8 => cod_digit_2nd <= "0000000";
     when 7 => cod_digit_2nd <= "1111000";
     when 6 => cod_digit_2nd <= "0000010";
     when 5 => cod_digit_2nd <= "0010010";
     when 4 => cod_digit_2nd <= "0011001";
     when 3 => cod_digit_2nd <= "0110000";
     when 2 => cod_digit_2nd <= "0100100";
     when 1 => cod_digit_2nd <= "1111001";
     when 0 => cod_digit_2nd <= "1000000";
end case;
     
case digit_1st is
     when 9 => cod_digit_1st <= "0010000";
     when 8 => cod_digit_1st <= "0000000";
     when 7 => cod_digit_1st <= "1111000";
     when 6 => cod_digit_1st <= "0000010";
     when 5 => cod_digit_1st <= "0010010";
     when 4 => cod_digit_1st <= "0011001";
     when 3 => cod_digit_1st <= "0110000";
     when 2 => cod_digit_1st <= "0100100";
     when 1 => cod_digit_1st <= "1111001";
     when 0 => cod_digit_1st <= "1000000";
end case;
end process;

end Behavioral;
