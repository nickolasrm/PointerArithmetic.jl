@testset "ArraySlice" begin
    a = [1,2,3,4]
    b = ArraySlice(a, 2:3)
    @test b[1] == a[2]
    b[1] = 100
    @test a[2] == 100
    @test length(b) == 2
    b = b >> 1
    @test length(b) == 3
    @test b[3] == 4
    b = b << 1
    @test length(b) == 2
    @test b[1] == 3
    b = b >> -1
    @test length(b) == 1
    b = b << -2
    @test length(b) == 3
    @test b[1] == 1
end