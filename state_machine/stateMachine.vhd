library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stateMachine is
    port(
        clk : in std_logic;
        reset : in std_logic;
        state_out : out std_logic
    );
end entity;

architecture a_stateMachine of stateMachine is 
    signal state: std_logic;
    
begin
    process(clk, reset)
    begin
        if reset = '1'then state <= '0';
        elsif rising_edge(clk) then
            state <= not state;
         end if;
    end process;

    state_out <= state;
end architecture;