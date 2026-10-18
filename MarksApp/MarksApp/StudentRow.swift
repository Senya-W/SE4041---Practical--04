import SwiftUI

// Reusable subview for one row of the student list.
// Pass/Fail is shown with an icon and text as well as colour,
// so the result does not rely on colour alone.
struct StudentRow: View {
    let student: Student

    var body: some View {
        HStack {
            Text(student.name)

            Spacer()

            Text("\(student.mark)")
                .bold()

            Label(
                student.passed ? "Pass" : "Fail",
                systemImage: student.passed ? "checkmark.circle.fill" : "xmark.circle.fill"
            )
            .font(.subheadline)
            .foregroundStyle(student.passed ? .green : .red)
        }
    }
}

#Preview {
    StudentRow(student: Student(name: "Amal", mark: 72))
        .padding()
}
