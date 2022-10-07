library ieee;
use ieee.std_logic_1164.all;
package Flipflops is
component dff_set is port(D,clock,set:in std_logic;Q:out std_logic);
end component dff_set;
component dff_reset is port(D,clock,reset:in std_logic;Q:out std_logic);
end component dff_reset;
end package Flipflops;
--D flip flop with set
library ieee;
use ieee.std_logic_1164.all;
entity dff_set is port(D,clock,set:in std_logic;Q:out std_logic);
end entity dff_set;
architecture behav of dff_set is
begin
dff_set_proc: process (clock,set)
begin
if(set='1')then -- set implies flip flip output logic high
Q <= '1'; -- write the flip flop output when set
elsif (clock'event and (clock='1')) then
Q <= D; -- write flip flop output when not set
end if ;
end process dff_set_proc;
end behav;
--D flip flop with reset
library ieee;
use ieee.std_logic_1164.all;
entity dff_reset is port(D,clock,reset:in std_logic;Q:out std_logic);
end entity dff_reset;
architecture behav of dff_reset is
begin
dff_reset_proc: process (clock,reset)
begin
if(reset='1')then -- reset implies flip flip output logic low
Q <= '0'; -- write the flip flop output when reset
elsif (clock'event and (clock='1')) then
Q <= D ; -- write flip flop output when not reset
end if ;
end process dff_reset_proc;
end behav;
library ieee;
use ieee.std_logic_1164.all;
use work.FlipFLops.all;
entity exp7 is
port (reset,clock: in std_logic;
y:out std_logic);
end entity exp7;
architecture struct of exp7 is
signal D :std_logic_vector(2 downto 0);
signal Q:std_logic_vector(2 downto 0);
signal Q_bar: std_logic_vector( 2 downto 0);
	component dff_reset is port(D,clock,reset:in std_logic;Q:out std_logic);
	end component dff_reset;
	component dff_set is port(D,clock,set:in std_logic;Q:out std_logic);
end component dff_set;
begin
-- write the equations in dataflow e.g z=a+bc written as z <= a or (b and c)
-- for DFF inputs which was derived and also for y.
-- Instantiate components dff_reset
-- and dff_set appropriately using port map statements.
	ff1:dff_reset port map(d(2),Clock,reset,q(2));
	ff2:dff_reset port map(d(1),Clock,reset,q(1));
	ff3:dff_set port map(d(0),Clock,reset,q(0));
	
	q_bar(0) <= not(q(0)) ;
	q_bar(1) <= not(q(1)) ;
	q_bar(2) <= not(q(2)) ;
	d(2) <= (((q_bar(2) and q(0)) and q(1)) or (q(2) and q_bar(1)));
	d(1) <= (q_bar(2) and (q(0) xor q(1))) or ((q(2) and q_bar(1)) and q_bar(0)) ;
	d(0) <= (q_bar(0) and q_bar(2)) or q(1);
	y <= q(0);
end struct;