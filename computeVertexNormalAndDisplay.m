function [triangulatedVertex, vertexnormals, facenormals] = computeVertexAndFaceNormalAndDisplay(vertex, faces)

	triangulatedVertex = triangulation(faces, vertex);
	vertexnormals      = vertexNormal(triangulatedVertex);
	facenormals        = faceNormal(triangulatedVertex);

	%displayNormals(triangulatedVertex, faces, vertex, vertexnormals, facenormals);
end