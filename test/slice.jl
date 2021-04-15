@testset "Slice" begin
    a = [1,2,3,4]
    b = Slice(a, 2:4)
    @test b[1] == a[2]
    @test b[0] == a[1]
    b = b << -1
    @test length(b) == 4
    @test b[1] == a[1]
    b = b >> -1
    @test length(b) == 3
    @test b[3] == a[3]
    @test b[4] == a[4]
    b[4] = 10000
    @test a[4] == 10000
    try
        b = Slice(a, 3:2)
        @test 1 == 0
    catch
        @test 1 == 1
    end
end