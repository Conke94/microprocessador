library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end entity;

architecture a_ula_tb of ula_tb is
    component ula
        port(   
            x,y       :  in  unsigned(15 downto 0);
            out_a :  out unsigned(15 downto 0);
            select_operation_a, select_operation_b : in std_logic;
            flag_zero: out std_logic
        );
    end component;

    signal x, y, out_a : unsigned(15 downto 0);
    signal select_operation_a, select_operation_b, flag_zero : std_logic;

    begin
        uut : ula port map(
            x => x,
            y => y,
            out_a => out_a,
            select_operation_a => select_operation_a,
            select_operation_b => select_operation_b,
            flag_zero => flag_zero
        );
    
        process
            begin
                x <= "1111111111111111";
                y <= "1111111111111111";
                select_operation_a <= '0';
                select_operation_b <= '0';
                wait for 50 ns;
                x <= "1111111111111111";
                y <= "1111111111111111";
                select_operation_a <= '0';
                select_operation_b <= '1';
                wait for 50 ns;
                x <= "0000000000000000";
                y <= "0000000000000000";
                select_operation_a <= '0';
                select_operation_b <= '0';
                wait for 50 ns;
                x <= "0000000000000000";
                y <= "0000000000000000";
                select_operation_a <= '0';
                select_operation_b <= '1';
                wait for 50 ns;
                x <= "0000000000001000";
                y <= "0000000000000100";
                select_operation_a <= '0';
                select_operation_b <= '0';
                wait for 50 ns;
                x <= "0000000000001000";
                y <= "0000000000000100";
                select_operation_a <= '0';
                select_operation_b <= '1';
                wait for 50 ns;
                x <= "0000000000000100";
                y <= "0000000000001000";
                select_operation_a <= '0';
                select_operation_b <= '0';
                wait for 50 ns;
                x <= "0000000000000100";
                y <= "0000000000001000";
                select_operation_a <= '0';
                select_operation_b <= '1';
                wait for 50 ns;
                x <= "1010101010101010";
                y <= "0000000000000011";
                select_operation_a <= '1';
                select_operation_b <= '0';
                wait for 50 ns;
                wait;
    end process;

end architecture;