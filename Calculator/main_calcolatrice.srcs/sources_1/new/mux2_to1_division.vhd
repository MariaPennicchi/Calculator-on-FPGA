----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 16:48:31
-- Design Name: 
-- Module Name: mux2_to1_division - Behavioral
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

entity mux2_to1_division is
    Port ( q_in : in STD_LOGIC_VECTOR (27 downto 0);
           remainder_in : in STD_LOGIC_VECTOR (27 downto 0);
           out_division : out STD_LOGIC_VECTOR (27 downto 0);
           select_out : in STD_LOGIC);
end mux2_to1_division;

architecture Behavioral of mux2_to1_division is

begin
process (select_out, q_in, remainder_in)
begin
if select_out = '1' then
    out_division <= q_in;
elsif select_out = '0' then
    out_division <= remainder_in;
end if;
end process;

end Behavioral;
