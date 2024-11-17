library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stateMachine_tb is
end entity;

architecture a_stateMachine_tb of stateMachine_tb is 
    component stateMachine
        port(
            clk : in std_logic;
            reset : in std_logic;
            state_out : out std_logic
        );
    end component;

    constant period : time := 100 ns;
    signal finished : std_logic := '0';
    signal state_out : std_logic;
    signal clk, reset : std_logic;

    begin
        uut: stateMachine port map (
            state_out => state_out,
            clk => clk, reset => reset
        );

        reset_global : process
        begin
            reset <= '1';
            wait for period*2;
            reset <= '0';
            wait;
        end process reset_global;

        sim_time_proc : process
        begin
            wait for 10 us;
            finished <= '1';
            wait;
        end process sim_time_proc;

        clock_proc: process
        begin
            while finished /= '1' loop
                clk <= '0';
                wait for period / 2;
                clk <= '1';
                wait for period / 2;
            end loop;
            wait;
        end process clock_proc;

        process
            begin 
                wait for 200 ns;
                wait for 100 ns;
                wait for 100 ns;
                wait for 100 ns;
                wait for 100 ns;
                wait;
        end process;
end architecture;