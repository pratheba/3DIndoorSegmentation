function [triangulatedVertex, vertexnormals, facenormals] = computeVertexAndFaceNormalAndDisplay(faces,vertices)

           [triangulatedVertex, vertexnormals, facenormals] = ComputeVertexAndFaceNormal(faces,vertices);
	
	incenterofTriangles = incenter(triangulatedVertex);
	
	displayNormals(triangulatedVertex, vertices, vertexnormals, incenterofTriangles, facenormals);

end