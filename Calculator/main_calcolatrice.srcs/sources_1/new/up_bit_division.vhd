----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2023 22:38:23
-- Design Name: 
-- Module Name: up_bit_division - Behavioral
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

entity up_bit_division is
    Port ( q : in STD_LOGIC_VECTOR (15 downto 0);
           remainder : in STD_LOGIC_VECTOR (15 downto 0);
           q_out : out STD_LOGIC_VECTOR (27 downto 0) := (others=> '0');
           rem_out : out STD_LOGIC_VECTOR (27 downto 0) := (others=> '0'));
           
end up_bit_division;

architecture Behavioral of up_bit_division is



begin
q_out <= "00000000000000" & q(13 downto 0);
rem_out <= "00000000000000" & remainder(13 downto 0);

end Behavioral;
