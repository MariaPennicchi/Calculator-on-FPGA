----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2023 23:10:30
-- Design Name: 
-- Module Name: mux4_to1 - Behavioral
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

entity mux4_to1 is
    Port ( add : in STD_LOGIC_VECTOR (27 downto 0);
           mul : in STD_LOGIC_VECTOR (27 downto 0);
           dif : in STD_LOGIC_VECTOR (27 downto 0);
           div : in STD_LOGIC_VECTOR (27 downto 0);
           out_operation : out STD_LOGIC_VECTOR (27 downto 0);
           select_out : in STD_LOGIC_VECTOR (1 downto 0));
end mux4_to1;

architecture Behavioral of mux4_to1 is

begin
process(select_out)
begin

case select_out is
when "00" => out_operation <= add;
when "01" => out_operation <= mul;
when "10" => out_operation <= div;
when "11" => out_operation <= dif;
end case;
end process;

end Behavioral;
