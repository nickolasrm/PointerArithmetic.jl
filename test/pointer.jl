@testset "Pointer" begin
    a = [1,2,3,4]
    pt = Pointer(a)
    @test pt[3] == 3
    pt = Pointer(a, 2)
    @test pt[0] == 2
    @test pt[1] == 3
    pt = pt << 1
    @test pt[0] == 3
    pt[0] = 5
    @test pt[0] == 5
    try
        b = Slice(a, 3:2)
        @test 1 == 0
    catch
        @test 1 == 1
    end
end