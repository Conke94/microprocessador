library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_tb is
end entity;

architecture a_banco_tb of banco_tb is 
    component banco
        port(
            clk, reset, wr_en : in std_logic;
            reg_wr: in unsigned(2 downto 0);
            reg_read: in unsigned(2 downto 0);
            data_in : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    constant period : time := 100 ns;
    signal finished : std_logic := '0';

    signal data_in, data_out : unsigned(15 downto 0);
    signal clk, reset, wr_en : std_logic;
    signal reg_wr, reg_read : unsigned(2 downto 0);

    begin
        uut: banco port map (
            data_in => data_in, data_out => data_out,
            reg_wr => reg_wr, reg_read => reg_read,
            clk => clk, reset => reset,
            wr_en => wr_en
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
                data_in <= "1111111111111111";
                reg_wr <= "000";
                wr_en <= '1';
                wait for 100 ns;
                data_in <= "1110000000000000";
                reg_wr <= "000";
                wr_en <= '0';
                wait for 100 ns;
                data_in <= "1111111111111111";
                reg_wr <= "001";
                wr_en <= '1';
                wait for 100 ns;
                data_in <= "1111111111111111";
                reg_wr <= "010";
                wr_en <= '1';
                wait for 100 ns;
                data_in <= "1001111001110001";
                reg_wr <= "011";
                wr_en <= '1';
                wait for 100 ns;
                data_in <= "1010101010101010";
                reg_wr <= "100";
                wr_en <= '1';
                wait for 100 ns;
                data_in <= "1010101010101010";
                reg_read <= "100";
                reg_wr <= "100";
                wr_en <= '0';
                wait for 100 ns;
                reg_read <= "001";
                wr_en <= '0';
                wait for 100 ns;
                reg_read <= "000";
                wr_en <= '0';
                wait for 100 ns;
                wait;
        end process;
end architecture;