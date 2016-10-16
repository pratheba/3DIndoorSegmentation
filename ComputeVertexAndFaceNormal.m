function [triangulatedVertex, vertexnormals, facenormals] = ComputeVertexAndFaceNormal(faces,vertices)
    triangulatedVertex = triangulation(faces,vertices);
    vertexnormals = vertexNormal(triangulatedVertex);
    facenormals        = faceNormal(triangulatedVertex);
end