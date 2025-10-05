---------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2023 12:43:13
-- Design Name: 
-- Module Name: sommatore - Behavioral
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

entity sommatore is
               Port(     a, b : in std_logic_vector(13 downto 0);
                         s : out std_logic_vector(27 downto 0));
end sommatore;

architecture Behavioral of sommatore is
component full_adder is port ( 
          a,b,cin: in std_logic;
          cout, s : out std_logic);
end component full_adder;

signal cout_1 : std_logic_vector(13 downto 0);

begin

u1 : full_adder port map (a =>a(0) , b => b(0), cin =>'0', cout =>cout_1(0), s=>s(0));

fag: for i in 1 to 13 generate 
    ui: full_adder port map (a =>a(i) , b => b(i), cin =>cout_1(i-1), cout =>cout_1(i), s=>s(i));
end generate fag;
s(14) <= cout_1(13);
s (27 downto 15) <= "0000000000000";
end Behavioral;