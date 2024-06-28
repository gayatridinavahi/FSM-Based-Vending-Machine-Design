module hw24 (
    input clk, rst, wr, rd,
    input [7:0] din,
    output reg [7:0] dout,
    output reg [3:0] wrptr, rdptr,
    output reg almostfull, almostempty
);


reg [7:0] Box1, Box2, Box3, Box4, Box5, Box6, Box7, Box8, Box9, Box10;

enum {EMP,PAR,FUL} state;
wire [3:0] wrnext,rdnext;
wire s1;


assign s1=(wrnext==rdnext);
assign almostfull = (state==PAR) && ((wrptr==8 || wrptr==9 || wrptr==10) || (rdptr==2 || rdptr==3 || rdptr==4));
assign almostempty = (state==PAR) && ((rdptr==8 || rdptr==9 | rdptr==10) || ((wrnext==3 || wrnext==4 || wrnext==5) && dout==0));


always @(posedge clk or posedge rst)
begin
	if (rst) state<=EMP;
	else
	case(state)
	EMP: state<= wr ? PAR : EMP;
	PAR: if (rd) 
			state<= (rdnext==wrptr) ? EMP : PAR;
		else
			begin
			if (wr) 
			state <= s1 ? FUL : PAR;
			else state <= PAR;
			end
		
	FUL: state <= rd ? PAR : FUL;
	endcase
end
	

always @(posedge clk or posedge rst)
begin
	if (rst) wrptr<=1;
	else 
	case (state) 
	EMP,PAR: wrptr <= wr ? wrnext : wrptr;
	FUL: wrptr<=wrptr;
	endcase
end

assign wrnext = wrptr==10 ? 1 : (wrptr+1);
assign rdnext = rdptr==10 ? 1 : (rdptr+1);

always @(posedge clk or posedge rst)
begin
	if (rst) rdptr<=1;
	else 
	case (state) 
	FUL,PAR: rdptr<= rd ? (rdnext) : rdptr;
	EMP: rdptr <= rdptr;
	endcase
end

always @(posedge clk or posedge rst)
begin
	if (rst) Box1<= 0;
	else 
	case (state) 
	EMP,PAR: if (wr && wrptr ==1) Box1<=din;
	endcase
end

always @(posedge clk or posedge rst)
begin
	if (rst) Box2<= 0;
	else 
	case (state) 
	EMP,PAR: if (wr && wrptr ==2) Box2<=din;
	endcase
end

always @(posedge clk or posedge rst)
begin
	if (rst) Box3<= 0;
	else 
	case (state) 
	EMP,PAR: if (wr && wrptr ==3) Box3<=din;
	endcase
end

always @(posedge clk or posedge rst)
begin
	if (rst) Box4<= 0;
	else 
	case (state) 
	EMP,PAR: if (wr && wrptr ==4) Box4<=din;
	endcase
end

always @(posedge clk or posedge rst)
begin
	if (rst) Box5<= 0;
	else 
	case (state) 
	EMP,PAR: if (wr && wrptr ==5) Box5<=din;
	endcase
end

always @(posedge clk or posedge rst)
begin
	if (rst) Box6<= 0;
	else 
	case (state) 
	EMP,PAR: if (wr && wrptr ==6) Box6<=din;
	endcase
end

always @(posedge clk or posedge rst)
begin
	if (rst) Box7<= 0;
	else 
	case (state) 
	EMP,PAR: if (wr && wrptr ==7) Box7<=din;
	endcase
end

always @(posedge clk or posedge rst)
begin
	if (rst) Box8<= 0;
	else 
	case (state) 
	EMP,PAR: if (wr && wrptr ==8) Box8<=din;
	endcase
end

always @(posedge clk or posedge rst)
begin
	if (rst) Box9<= 0;
	else 
	case (state) 
	EMP,PAR: if (wr && wrptr ==9) Box9<=din;
	endcase
end

always @(posedge clk or posedge rst)
begin
	if (rst) Box10<= 0;
	else 
	case (state) 
	EMP,PAR: if (wr && wrptr ==10) Box10<=din;
	endcase
end

always @(posedge clk or posedge rst)
begin
	if (rst) dout<=8'b0;
	else 
	case(state) 
	PAR,FUL: 
		if(rd)
		begin
		case(rdptr)
		1: dout<=Box1;
		2: dout<=Box2;
		3: dout<=Box3;
		4: dout<=Box4;
		5: dout<=Box5;
		6: dout<=Box6;
		7: dout<=Box7;
		8: dout<=Box8;
		9: dout<=Box9;
		10: dout<=Box10;
		endcase
		end
	else dout<=dout;
	endcase
end

endmodule
