function [triangulatedVertex, vertexnormals, facenormals] = computeVertexAndFaceNormalAndDisplay(vertices, faces)

           [triangulatedVertex, vertexnormals, facenormals] = ComputeVertexAndFaceNormal(vertices,faces);
	
	incenterofTriangles = incenter(triangulatedVertex);
	
	displayNormals(triangulatedVertex, vertices, vertexnormals, incenterofTriangles, facenormals);

end