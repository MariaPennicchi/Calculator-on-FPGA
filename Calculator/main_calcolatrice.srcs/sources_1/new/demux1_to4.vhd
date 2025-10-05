----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2023 10:04:26
-- Design Name: 
-- Module Name: demux1_to4 - Behavioral
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

entity demux1_to4 is
    Port ( in14bit : in STD_LOGIC_VECTOR (13 downto 0);
           add : out STD_LOGIC_VECTOR (13 downto 0);--ok
           mul : out STD_LOGIC_VECTOR (13 downto 0);--ok
           div : out STD_LOGIC_VECTOR (15 downto 0);
           dif : out STD_LOGIC_VECTOR (15 downto 0);
           select_out : in STD_LOGIC_VECTOR (1 downto 0));
end demux1_to4;

architecture Behavioral of demux1_to4 is

begin
process (select_out)
variable temp_div , temp_dif : std_logic_vector(15 downto 0);
begin
temp_div:="00" & in14bit(13 downto 0);
temp_dif:="00" & in14bit(13 downto 0);

case select_out is
when "00" => add <= in14bit;
when "01" => mul <= in14bit;
when "10" => div <= temp_div;
when "11" => dif <= temp_dif;
end case;
end process;

end Behavioral;
