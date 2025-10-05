
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity full_adder is
 Port ( a,b,cin :in std_logic;
       cout,s :out std_logic );
end full_adder;

architecture behavioral of full_adder is

begin
process (a,b,cin)
begin
s <= a xor b xor cin;
cout <= (b and cin) or (a and cin) or (a and b);
end process;
end behavioral;
