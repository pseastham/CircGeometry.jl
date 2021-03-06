using CircGeometry

function create_circle()
    vf = 0.4
    n_bodies = 400
    material = MaterialParameters(vf,n_bodies)
    
    radius = 1.5
    center = Point(-0.5,1.0)
    outline = OutlineCircle(radius,center)

    between_buffer = compute_between_buffer(outline,material)
    ps = generate_porous_structure(
        outline,material,between_buffer;log=true)

    write_circ("circle.circ",ps)
    save_image("circle.svg",ps,outline)
end

function create_rectangle()
    vf = 0.4
    n_bodies = 400
    material = MaterialParameters(vf,n_bodies)

    p1 = Point(-1.0,0.0)
    p2 = Point(1.0,2.0)
    outline = OutlineRectangle(p1,p2)

    between_buffer = compute_between_buffer(outline,material)
    ps = generate_porous_structure(
        outline,material,between_buffer;log=true)

    write_circ("rectangle.circ",ps)
    save_image("rectangle.svg",ps,outline)
end

function create_car()
    vf = 0.4
    n_bodies = 400
    material = MaterialParameters(vf,n_bodies)

    polygon = csv_to_polygon("car.txt")
    outline = OutlinePolygon(polygon)

    between_buffer = compute_between_buffer(outline,material)
    ps = generate_porous_structure(
        outline,material,between_buffer;log=true)

    write_circ("car.circ",ps)
    save_image("car.svg",ps,outline)
end

function run_all_examples()
    println("running circle example...")
    create_circle()
    println("running rectangle example...")
    create_rectangle()
    println("running car (polygon) example...")
    create_car()
end 
