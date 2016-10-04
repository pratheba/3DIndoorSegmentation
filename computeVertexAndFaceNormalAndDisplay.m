function [triangulatedVertex, vertexnormals, facenormals] = computeVertexAndFaceNormalAndDisplay(vertex, faces)

	triangulatedVertex = triangulation(faces, vertex);
	vertexnormals = vertexNormal(triangulatedVertex);

	incenterofTriangles = incenter(triangulatedVertex);
	facenormals        = faceNormal(triangulatedVertex);

	displayNormals(triangulatedVertex, vertex, vertexnormals, incenterofTriangles, facenormals);

end