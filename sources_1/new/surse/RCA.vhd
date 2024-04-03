library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;

entity RCA is
    Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
           y : in STD_LOGIC_VECTOR (31 downto 0);
           cin : in STD_LOGIC;
           rez : out STD_LOGIC_VECTOR (31 downto 0);
           cout : out STD_LOGIC);
end RCA;

architecture Behavioral of RCA is

component FA is 
Port( 
x : in STD_LOGIC;
y : in STD_LOGIC;
cin : in STD_LOGIC;
rez : out STD_LOGIC;
cout : out STD_LOGIC
);
end component;

signal carry: std_logic_vector(31 downto 0);
signal r: std_logic_vector(31 downto 0);

begin

et0: FA port map (x(0),y(0),cin,r(0),carry(1)); 

loopp: for i IN 1 to 30 generate
et1to30: FA port map (x(i),y(i),carry(i),r(i),carry(i+1)); 
end generate;

et31: FA port map(x(31),y(31),carry(31),r(31),cout);

rez<=r;


end Behavioral;