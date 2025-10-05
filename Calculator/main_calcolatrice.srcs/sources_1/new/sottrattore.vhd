library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sottrattore is
    Port ( n1 : in STD_LOGIC_VECTOR (15 downto 0);
           n2 : in STD_LOGIC_VECTOR (15 downto 0);
           o : out STD_LOGIC_VECTOR (27 downto 0):= (others=>'0');
           neg : out STD_LOGIC);
          -- reset : in STD_LOGIC);
end sottrattore; 

architecture Behavioral of sottrattore is
component sottrattore_positivo is 
port(n1, n2 : in std_logic_vector(15 downto 0); 
     o : out std_logic_vector(15 downto 0):= (others=>'0')); 
end component sottrattore_positivo;

signal temp1: std_logic_vector(15 downto 0); 
signal temp2: std_logic_vector(15 downto 0); 
begin


process(n1, n2)
begin
if (n1 >= n2) then 
    temp1<=n1;
    temp2<=n2;
    neg<='0';
else
    temp1<=n2; 
    temp2<=n1;
    neg<='1';
end if; 

--if reset='1' then
--    temp1<="0000000000000000";
--    temp2<="0000000000000000";
--end if;
end process;

sp: sottrattore_positivo port map (n1 => temp1, n2 => temp2, o => o(15 downto 0));
o (27 downto 16) <= (others=>'0');
end Behavioral;