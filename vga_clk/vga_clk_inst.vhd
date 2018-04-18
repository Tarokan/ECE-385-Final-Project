	component vga_clk is
		port (
			clk_clk                           : in  std_logic := 'X'; -- clk
			reset_reset_n                     : in  std_logic := 'X'; -- reset_n
			altpll_0_c0_clk                   : out std_logic;        -- clk
			altpll_0_phasedone_conduit_export : out std_logic;        -- export
			altpll_0_locked_conduit_export    : out std_logic;        -- export
			altpll_0_areset_conduit_export    : in  std_logic := 'X'  -- export
		);
	end component vga_clk;

	u0 : component vga_clk
		port map (
			clk_clk                           => CONNECTED_TO_clk_clk,                           --                        clk.clk
			reset_reset_n                     => CONNECTED_TO_reset_reset_n,                     --                      reset.reset_n
			altpll_0_c0_clk                   => CONNECTED_TO_altpll_0_c0_clk,                   --                altpll_0_c0.clk
			altpll_0_phasedone_conduit_export => CONNECTED_TO_altpll_0_phasedone_conduit_export, -- altpll_0_phasedone_conduit.export
			altpll_0_locked_conduit_export    => CONNECTED_TO_altpll_0_locked_conduit_export,    --    altpll_0_locked_conduit.export
			altpll_0_areset_conduit_export    => CONNECTED_TO_altpll_0_areset_conduit_export     --    altpll_0_areset_conduit.export
		);

