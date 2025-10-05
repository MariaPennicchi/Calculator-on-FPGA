library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bin_to_7seg is
    Port (bin: in std_logic_vector(27 downto 0);
          --cod_digit_8th, cod_digit_7th, cod_digit_6th, cod_digit_5th, cod_digit_4th, cod_digit_3rd, cod_digit_2nd, cod_digit_1st : out std_logic_vector(6 downto 0);
          display_number:out std_logic_vector(55 downto 0)
          );
end bin_to_7seg;

architecture Behavioral of bin_to_7seg is
signal cod_digit_8th, cod_digit_7th, cod_digit_6th, cod_digit_5th, cod_digit_4th, cod_digit_3rd, cod_digit_2nd, cod_digit_1st :  std_logic_vector(6 downto 0);
          
begin

process (bin)
variable int: integer;
variable digit_8th, digit_7th, digit_6th, digit_5th, digit_4th, digit_3rd, digit_2nd, digit_1st : integer range 0 to 9;
variable mod_digit_8th, mod_digit_7th, mod_digit_6th, mod_digit_5th, mod_digit_4th, mod_digit_3rd, mod_digit_2nd: integer := 0;

begin
int := to_integer(unsigned(bin)); 

mod_digit_8th := int mod 10000000;
digit_8th := (int - mod_digit_8th)/10000000;

mod_digit_7th := mod_digit_8th mod 1000000;
digit_7th := (mod_digit_8th - mod_digit_7th)/1000000;

mod_digit_6th := mod_digit_7th mod 100000;
digit_6th := (mod_digit_7th - mod_digit_6th)/100000;

mod_digit_5th := mod_digit_6th mod 10000; 
digit_5th := (mod_digit_6th - mod_digit_5th)/10000; 

mod_digit_4th := mod_digit_5th mod 1000; 
digit_4th := (mod_digit_5th - mod_digit_4th )/1000;

mod_digit_3rd := mod_digit_4th mod 100; 
digit_3rd := (mod_digit_4th - mod_digit_3rd)/100; 

mod_digit_2nd := mod_digit_3rd mod 10;
digit_2nd := (mod_digit_3rd - mod_digit_2nd)/10;

digit_1st := mod_digit_2nd;

case digit_8th is
     when 9 => cod_digit_8th <= "0010000";
     when 8 => cod_digit_8th <= "0000000";
     when 7 => cod_digit_8th <= "1111000";
     when 6 => cod_digit_8th <= "0000010";
     when 5 => cod_digit_8th <= "0010010";
     when 4 => cod_digit_8th <= "0011001";
     when 3 => cod_digit_8th <= "0110000";
     when 2 => cod_digit_8th <= "0100100";
     when 1 => cod_digit_8th <= "1111001";
     when 0 => cod_digit_8th <= "1000000";
end case;

case digit_7th is
     when 9 => cod_digit_7th <= "0010000";
     when 8 => cod_digit_7th <= "0000000";
     when 7 => cod_digit_7th <= "1111000";
     when 6 => cod_digit_7th <= "0000010";
     when 5 => cod_digit_7th <= "0010010";
     when 4 => cod_digit_7th <= "0011001";
     when 3 => cod_digit_7th <= "0110000";
     when 2 => cod_digit_7th <= "0100100";
     when 1 => cod_digit_7th <= "1111001";
     when 0 => cod_digit_7th <= "1000000";
end case;

case digit_6th is
     when 9 => cod_digit_6th <= "0010000";
     when 8 => cod_digit_6th <= "0000000";
     when 7 => cod_digit_6th <= "1111000";
     when 6 => cod_digit_6th <= "0000010";
     when 5 => cod_digit_6th <= "0010010";
     when 4 => cod_digit_6th <= "0011001";
     when 3 => cod_digit_6th <= "0110000";
     when 2 => cod_digit_6th <= "0100100";
     when 1 => cod_digit_6th <= "1111001";
     when 0 => cod_digit_6th <= "1000000";
end case;

case digit_5th is
     when 9 => cod_digit_5th <= "0010000";
     when 8 => cod_digit_5th <= "0000000";
     when 7 => cod_digit_5th <= "1111000";
     when 6 => cod_digit_5th <= "0000010";
     when 5 => cod_digit_5th <= "0010010";
     when 4 => cod_digit_5th <= "0011001";
     when 3 => cod_digit_5th <= "0110000";
     when 2 => cod_digit_5th <= "0100100";
     when 1 => cod_digit_5th <= "1111001";
     when 0 => cod_digit_5th <= "1000000";
end case;

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

display_number (55 downto 49) <= cod_digit_8th;
display_number (48 downto 42) <= cod_digit_7th;
display_number (41 downto 35) <= cod_digit_6th;
display_number (34 downto 28) <= cod_digit_5th;
display_number (27 downto 21) <= cod_digit_4th;
display_number (20 downto 14) <= cod_digit_3rd;
display_number (13 downto 7) <= cod_digit_2nd;
display_number (6 downto 0) <= cod_digit_1st;


end Behavioral;
