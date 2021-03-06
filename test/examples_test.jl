using CircGeometry, Test

@testset "circle example test" begin
    vf = 0.05
    n_bodies = 400
    material = MaterialParameters(vf,n_bodies)
    
    radius = 1.5
    center = Point(-0.5,1.0)
    outline = OutlineCircle(radius,center)

    between_buffer = compute_between_buffer(outline,material)
    ps = generate_porous_structure(outline,material,between_buffer;log=true)

    write_circ("circle.circ",ps)
    save_image("circle.svg",ps,outline)
end

@testset "rectangle example test" begin
    vf = 0.15
    n_bodies = 400
    material = MaterialParameters(vf,n_bodies)

    p1 = Point(-1.0,0.0)
    p2 = Point(1.0,2.0)
    outline = OutlineRectangle(p1,p2)

    between_buffer = compute_between_buffer(outline,material)
    ps = generate_porous_structure(outline,material,between_buffer;log=false)

    translate!(outline,1.0,-1.2)
    
    write_circ("rectangle.circ",ps)
    save_image("rectangle.svg",ps,outline)
end

@testset "polygon car example test" begin
    vf = 0.25
    n_bodies = 400
    material = MaterialParameters(vf,n_bodies)

    polygon = csv_to_polygon("test-data/car.txt")
    outline = OutlinePolygon(polygon)

    between_buffer = compute_between_buffer(outline,material)
    ps = generate_porous_structure(outline,material,between_buffer;log=false)

    translate!(outline,1.0,-1.2)

    write_circ("car.circ",ps)
    save_image("car.svg",ps,outline)
end

@testset "polygon car example test" begin
    vf = 0.35
    n_bodies = 400
    material = MaterialParameters(vf,n_bodies)

    polygon = csv_to_polygon("test-data/car.txt")
    outline = OutlinePolygon(polygon)

    between_buffer = compute_between_buffer(outline,material)
    ps = generate_porous_structure(outline,material,between_buffer;log=false)

    translate!(outline,1.0,-1.2)

    write_circ("car.circ",ps)
    save_image("car.svg",ps,outline)
end

# other compute_between_buffer tests
vf = 0.55
n_bodies = 400
material = MaterialParameters(vf,n_bodies)
polygon = csv_to_polygon("test-data/car.txt")
outline = OutlinePolygon(polygon)
between_buffer = compute_between_buffer(outline,material)

vf = 0.65
material = MaterialParameters(vf,n_bodies)
between_buffer = compute_between_buffer(outline,material)

rm("circle.circ")
rm("circle.svg")
rm("rectangle.circ")
rm("rectangle.svg")
rm("car.circ")
rm("car.svg")