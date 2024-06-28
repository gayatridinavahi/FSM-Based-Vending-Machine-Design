module tb;
reg clk,rst;
reg wr=0,rd=0;
reg wrNBA=0;
reg rdNBA=0;
reg [7:0] din=0,dinNBA=0;
always @* wrNBA<=wr;
always @* dinNBA<=din;
always @* rdNBA<=rd;
wire [3:0] wrptr,rdptr;
wire [7:0] dout;
wire almostfull, almostempty;

hw24 KABALI (clk, rst, wrNBA,rdNBA,dinNBA,dout, wrptr, rdptr,almostfull, almostempty);

always #5 clk=!clk;

initial
	begin
	clk=0;
	rst=1;
	#2;
	rst=0;
	end
	
initial
	begin 
	repeat(5) @(posedge clk);
	repeat(12) 
		begin
		wr=1;din=$random;@(posedge clk);wr=0;
			repeat($urandom_range(4,15)) @(posedge clk);
		end
	repeat(12) 
		begin
		rd=1;@(posedge clk);rd=0;
		repeat($urandom_range(4,15)) @(posedge clk);
		end
	$finish;
end

endmodule	
