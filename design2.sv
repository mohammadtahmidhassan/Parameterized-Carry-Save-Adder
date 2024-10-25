module design2 #(parameter WIDTH = 32) (input logic [(WIDTH-1):0] a,b,c,
output logic [(WIDTH+1):0] out);
logic [WIDTH:0] ps,cs,ipr, pr,gn;
logic [WIDTH+1:0] fs,fc;
logic [2*WIDTH-1:0] iipr;
logic [2*WIDTH:0] ign;
always_comb begin
        ps[WIDTH:0]= {1'b0 , a ^ (b ^ c)};
        cs[WIDTH:0] = {(a & b) | (c & (a | b)), 1'b0};
        pr = ps | cs;
        gn = ps & cs;
	fs  = {1'b0, pr ^ gn};
	ipr[WIDTH] = 1'b1;
	iipr[2*WIDTH-1:WIDTH] = pr[WIDTH:1];
	for (int i=0; i<=WIDTH-1; i++)
        begin
                iipr[i] = 1'b1;
        end
	for (int i=0; i<=WIDTH-1; i++) 
	begin
		ipr[WIDTH-1-i] = &iipr[i+:WIDTH+1]; 
	end
	fc[0] = 1'b0;
	ign[2*WIDTH:WIDTH] = gn;
	for (int i=0; i<=WIDTH-1; i++)
        begin
                ign[i] = 1'b0;
        end
	for (int i=1 ; i <=WIDTH+1 ; i++ ) 
	begin
		fc[i] =  |(gn[(i-1)+:(WIDTH+1)] & ipr);
	end 
	out = fs ^ fc;
end
endmodule
