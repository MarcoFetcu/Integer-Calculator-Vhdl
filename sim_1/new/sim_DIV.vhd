library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sim_DIV is
end sim_DIV;

architecture test of sim_DIV is
	signal reset : std_logic := '1';
	signal clk : std_logic := '0';
	signal a: std_logic_vector(63 downto 0);
   signal b: std_logic_vector(31 downto 0);
   signal result: std_logic_vector(63 downto 0) := (others => '0');
   signal valid: std_logic ;

 
 begin

	et: entity work.DIV port map(clk=>clk, reset=> reset, a=>a, b=>b, valid=>valid, result=>result);
	
end test;