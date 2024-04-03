library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DIV is
port(
	a : in std_logic_vector(63 downto 0);
	b : in std_logic_vector(31 downto 0);
	clk : in std_logic;
	reset : in std_logic;
	valid : out std_logic;
	result : out std_logic_vector(63 downto 0)
	);
end DIV;

architecture Behavioral of DIV is

type states is (init, start, exec);

signal state, nextstate : states; 
	
signal rez : std_logic_vector(64 downto 0) := (others => '0');
signal auxa : std_logic_vector(63 downto 0);
signal auxb : std_logic_vector(31 downto 0);
signal sub : std_logic_vector(32 downto 0);
signal bitt : std_logic;
signal cnt : std_logic_vector(5 downto 0);
	

begin
	
process(clk, reset) is
begin 
if (reset = '1') then
state <= init;
elsif (rising_edge(clk)) then
state <= nextstate;
end if;
end process;
	
	
process(clk, rez, auxb,state, cnt, a, b) is
begin

case state is
when init =>
if((auxa /= a) or (auxb /= b)) then
nextstate <= start;
else
nextstate <= init;
end if;
when start =>
nextstate <= exec;
when exec =>
if(unsigned(cnt) = 32) then
nextstate <= init;						
else 
nextstate <= exec;
end if;
when others =>
nextstate <= init;
end case;
end process;


process(reset, clk) is
begin

if (reset = '1') then
cnt <= (others => '0');
elsif (rising_edge(clk)) then
if (state = exec) then
if (unsigned(cnt) < 32) then
cnt <= std_logic_vector(unsigned(cnt) + 1);
end if;
elsif (state = init) then
cnt <= (others => '0');
end if;
end if;
end process;

		
process(reset, clk) is
begin
	
if (reset = '1') then
rez <= (others => '0');
auxa <= (others => '0');
auxb <= (others => '0');
elsif (rising_edge(clk)) then
if (state = exec) then
rez <= sub(31 downto 0) & rez(31 downto 0)& bitt;
elsif(state = start) then
auxa <= a;
auxb <= b;
rez <= '0' & a;
		
end if;
end if;
end process;
	
 
process(rez, auxb) is 
begin
if(state = exec) then
if (unsigned(rez(64 downto 32)) >= unsigned('0' & auxb)) then
sub <= std_logic_vector(unsigned(rez(64 downto 32)) - unsigned('0' & auxb));
bitt <= '1';
else
sub <= rez(64 downto 32);
bitt <= '0';
end if;
else 
sub <= (others => '0');
bitt <= '0';
end if;
end process;

process (reset, state) is
begin
if (reset = '1') then
result<=(others => '0');
valid <= '0';
else
if (state = init) then
if (unsigned(cnt) = 32) then
					
result<= rez(64 downto 33) & rez(31 downto 0);
valid <= '1';
else
valid <= '0';
end if;
else
valid <= '0';
end if;
end if;
end process;
end architecture;