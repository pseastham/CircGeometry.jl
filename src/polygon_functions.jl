import CSV

function is_inside_polygon(polygon::Vector{P}, p::P; extreme = Point(100_000.0, p.y)) where P<:Point
  n = length(polygon)
  # There must be at least 3 vertices in polygon
  if (n < 3); return false; end

  # Count intersections of the above line with sides of polygon
  count = 0
  for i=1:n
    next = mod(i,n)+1
    # Check if the line segment from 'p' to 'extreme' intersects
    # with the line segment from 'polygon[i]' to 'polygon[next]'
    if (doIntersect(polygon[i], polygon[next], p, extreme))
      # If the point 'p' is colinear with line segment 'i-next',
      # then check if it lies on segment. If it lies, return true,
      # otherwise false
      if (orientation(polygon[i], p, polygon[next]) == 0)
         return onSegment(polygon[i], p, polygon[next])
      end
      count += 1
    end
  end

  # Return true if count is odd, false otherwise
  if isodd(count)
    return true
  else
    return false
  end
end 

function doIntersect(p1::P,q1::P,p2::P,q2::P) where P<:Point
    # Find the four orientations needed for general case
    o1 = orientation(p1, q1, p2)
    o2 = orientation(p1, q1, q2)
    o3 = orientation(p2, q2, p1)
    o4 = orientation(p2, q2, q1)

    # General case
    if (o1 != o2 && o3 != o4)
        return true
    else
        return false
    end
end

function orientation(p::P,q::P,r::P) where P<:Point
    val = (q.y-p.y)*(r.x-q.x) - (q.x-p.x)*(r.y-q.y);

    if (val == 0) return 0 end  # colinear

    return (val > 0) ? 1 : 2 # clock- or counterclock-wise
end

function onSegment(p::P,q::P,r::P) where P<:Point
    maxX = (p.x >= r.x ? p.x : r.x)
    minX = (p.x >= r.x ? r.x : p.x)
    maxY = (p.y >= r.y ? p.y : r.y)
    minY = (p.y >= r.y ? p.y : r.y)

    if (q.x <= maxX && q.x >= minX && q.y <= maxY && q.y >= minY)
        return true
    else
        return false
    end
end

function csv_to_polygon(file_name::String)
    n_lines = 0
    for row in CSV.Rows(file_name;datarow=1)
        n_lines += 1
    end

    println(n_lines)

    xArr = zeros(n_lines)
    yArr = zeros(n_lines)

    ind = 1
    for row in CSV.Rows(file_name;datarow=1)
        xArr[ind] = parse(Float64,row[1])
        yArr[ind] = parse(Float64,row[2])
        ind += 1
    end

    pList = [Point(xArr[ti],yArr[ti]) for ti=1:n_lines]

    return pList
end