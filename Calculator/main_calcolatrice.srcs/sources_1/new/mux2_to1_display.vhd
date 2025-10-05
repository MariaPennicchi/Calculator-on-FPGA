----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 00:51:55
-- Design Name: 
-- Module Name: mux2_to1_display - Behavioral
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

entity mux2_to1_display is
    Port ( 
    clk, control_signal : in STD_LOGIC;
           an_input : in STD_LOGIC_VECTOR (3 downto 0);
           an_output : in STD_LOGIC_VECTOR (3 downto 0);
           in_seven_segment : in STD_LOGIC_VECTOR (6 downto 0);
           out_seven_segment : in STD_LOGIC_VECTOR (6 downto 0);
           out_an : out STD_LOGIC_VECTOR (3 downto 0);
           out_code : out STD_LOGIC_VECTOR (6 downto 0));
end mux2_to1_display;

architecture Behavioral of mux2_to1_display is

begin
process (clk)
begin
if (control_signal = '1') then
out_an <= an_input;
out_code <= in_seven_segment;
elsif (control_signal = '0')  then
out_an <= an_output;
out_code <= out_seven_segment;
end if;
end process;

end Behavioral;
