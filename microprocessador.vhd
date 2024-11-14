library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microprocessador is
    port(
        clk, reset, wr_en : in std_logic;
        reg_read, reg_wr: in unsigned(2 downto 0);
        operation : unsigned(1 downto 0);
        data_in : in unsigned(15 downto 0);
        data_out : out unsigned(15 downto 0);
        ula_zero, ula_carry : out std_logic;
        imm : in unsigned(15 downto 0);
        sel_imm : in std_logic
    );
end entity;

architecture a_microprocessador of microprocessador is 
    component banco is
        port(
        clk, reset, wr_en : in std_logic;
        reg_wr: in unsigned(2 downto 0);
        reg_read: in unsigned(2 downto 0);
        data_in : in unsigned(15 downto 0);
        data_out : out unsigned(15 downto 0)
    );
    end component;

    component ula is  
        port (   
        x,y : in unsigned(15 downto 0);
        out_a :  out unsigned(15 downto 0);
        operation : in unsigned(1 downto 0);
        flag_carry: out std_logic;
        flag_zero: out std_logic
    ); 
    end component;

    signal operando : unsigned(15 downto 0) := "0000000000000000";
    signal acumulador : unsigned(15 downto 0) := "0000000000000000";
    
    begin
        ula_main : ula PORT MAP(
            operation=>operation, 
            x=>operando, 
            y=>acumulador, 
            out_a=>acumulador, 
            flag_zero=>ula_zero,
            flag_carry=>ula_carry
        );
        
        banco_registradores : banco PORT MAP (
            clk=>clk,
            reset=>reset, 
            wr_en=>wr_en, 
            reg_wr=>reg_wr, 
            reg_read=>reg_read, 
            data_in=>data_in,
            data_out=>operando
        );

        operando <= imm when sel_imm = '1' else
            operando;

end architecture;