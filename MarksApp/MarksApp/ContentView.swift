import SwiftUI

struct ContentView: View {

    // Part B – State variables
    @State private var students: [Student] = []
    @State private var studentName = ""
    @State private var markText = ""
    @State private var errorMessage = ""

    // Part G – recalculated automatically whenever `students` changes
    private var passedCount: Int {
        students.filter { $0.passed }.count
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {

                // Part C – input interface
                VStack(spacing: 12) {
                    TextField("Student Name", text: $studentName)
                        .textFieldStyle(.roundedBorder)

                    TextField("Mark (0-100)", text: $markText)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)

                    Button("Add Student") {
                        addStudent()
                    }
                    .buttonStyle(.borderedProminent)

                    if !errorMessage.isEmpty {
                        Label(errorMessage, systemImage: "exclamationmark.triangle.fill")
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }
                }
                .padding(.horizontal)

                Text("Passed Students: \(passedCount)")
                    .font(.headline)

                // Part E – student list with navigation to the detail screen
                List(students) { student in
                    NavigationLink {
                        StudentDetailView(student: student)
                    } label: {
                        StudentRow(student: student)
                    }
                }
            }
            .navigationTitle("SE4041 Marks")
        }
    }

    // Part D – validate input and add a student
    private func addStudent() {
        let name = studentName.trimmingCharacters(in: .whitespaces)

        guard !name.isEmpty else {
            errorMessage = "Please enter a student name."
            return
        }

        guard let mark = Int(markText.trimmingCharacters(in: .whitespaces)) else {
            errorMessage = "Mark must be a whole number."
            return
        }

        guard mark >= 0 && mark <= 100 else {
            errorMessage = "Mark must be between 0 and 100."
            return
        }

        students.append(Student(name: name, mark: mark))

        // Clear the inputs and any old error
        studentName = ""
        markText = ""
        errorMessage = ""
    }
}

#Preview {
    ContentView()
}
