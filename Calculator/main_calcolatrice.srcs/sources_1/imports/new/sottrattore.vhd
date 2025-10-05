----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2023 15:05:47
-- Design Name: 
-- Module Name: sottrattore - Behavioral
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

entity sottrattore_positivo is
    Port ( n1, n2 : in std_logic_vector(15 downto 0); 
           --reset  : in std_logic;
           o : out std_logic_vector(15 downto 0):= (others=>'0')); 
end sottrattore_positivo;

architecture Behavioral of sottrattore_positivo is
component full_subtractor is port ( 
          n1,n2,cin: in std_logic;
          cout, o : out std_logic);
end component full_subtractor;

signal cout_1 : std_logic_vector(15 downto 0) := (others=>'0');

begin




u1 : full_subtractor port map (n1 => n1(0) , n2 => n2(0), cin => '0', cout => cout_1(0), o=> o(0));
fsg: for i in 1 to 15 generate 
    ui: full_subtractor port map (n1 => n1(i) , n2 => n2(i), cin => cout_1(i-1), cout => cout_1(i), o=> o(i));
end generate fsg;

end Behavioral;
