----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2023 13:08:38
-- Design Name: 
-- Module Name: full_subtractor - Behavioral
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

entity full_subtractor is
    Port (n1, n2, cin : in std_logic; --cin indica se hanno preso un unità da me
          o, cout : out std_logic ); --cout indica se io prendo un unità da quello a sx
end full_subtractor;

architecture dataflow of full_subtractor is
    
begin
    o <=(n1 and not n2 and not cin) or (not n1 and n2 and not cin) or (not n1 and not n2 and cin) or (n1 and n2 and cin); 
    cout <=(not n1 and n2) or (n1 and n2 and cin) or (not n1 and not n2 and cin);

end dataflow;
