import Testing
@testable import EngineeringKit

@Suite("Force Tests")
struct ForceTests {

    @Test
    func convertsKilonewtonsToNewtons() {
        let force = Force(value: 10, unit: .kilonewton)

        #expect(force.value(in: .newton) == 10_000)
    }

    @Test
    func convertsNewtonsToKilonewtons() {
        let force = Force(value: 1_500, unit: .newton)

        #expect(force.value(in: .kilonewton) == 1.5)
    }

    @Test
    func preservesValueInSameUnit() {
        let force = Force(value: 250, unit: .newton)

        #expect(force.value(in: .newton) == 250)
    }
}
