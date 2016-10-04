function [adjacencylist] = adjacencyMatrix2List(adjacencyMatrix)

	n = size(adjacencyMatrix,1);

	 for i=1:n
     	I = find( and( adjacencyMatrix(i,:)>0,  adjacencyMatrix(i,:)~=Inf) );
     	adjacencylist{i} = I;
     end
     %celldisp(adjacencylist);

		%adjacencylist=cellfun(@(x) find(x),num2cell(adjacencyMatrix,2),'un',0)
		%celldisp(adjacencylist)

		%[r,c] = find(adjacencyMatrix);
		%adjacencylist = [r,c];

		%maxVertexId = max(adjacencylist(:,2));

		%for i=1:maxVertexId

end