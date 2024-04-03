library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;

entity FA is 
Port( 
x : in STD_LOGIC;
y : in STD_LOGIC;
cin : in STD_LOGIC;
rez : out STD_LOGIC;
cout : out STD_LOGIC
);
end FA;

architecture Behavioral of FA is

begin
rez<= x XOR y XOR cin ;
cout <= (x AND y) OR (cin AND x) OR (cin AND y) ;
end Behavioral;
