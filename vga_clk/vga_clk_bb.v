
module vga_clk (
	clk_clk,
	reset_reset_n,
	altpll_0_c0_clk,
	altpll_0_phasedone_conduit_export,
	altpll_0_locked_conduit_export,
	altpll_0_areset_conduit_export);	

	input		clk_clk;
	input		reset_reset_n;
	output		altpll_0_c0_clk;
	output		altpll_0_phasedone_conduit_export;
	output		altpll_0_locked_conduit_export;
	input		altpll_0_areset_conduit_export;
endmodule
