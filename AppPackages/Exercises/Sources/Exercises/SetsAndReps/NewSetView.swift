//
// -----------------------------------------------------------
// Project: Exercises
// Created on 9/14/24 by @HeyJayWilson
// -----------------------------------------------------------
// Find HeyJayWilson on the web:
// 🕸️ Website             https://heyjaywilson.com
// 💻 Follow on GitHub:   https://github.com/heyjaywilson
// 🧵 Follow on Threads:  https://threads.net/@heyjaywilson
// 💭 Follow on Mastodon: https://iosdev.space/@heyjaywilson
// ☕ Buy me a ko-fi:     https://ko-fi.com/heyjaywilson
// -----------------------------------------------------------
// Copyright© 2024 CCT Plus LLC. All rights reserved.
//

import DataStorage
import SwiftData
import SwiftUI
import Utilities

enum TextFieldFocus: String {
	case reps
	case weight
}

struct NewSetView: View {
	@Environment(\.dismiss) var dismiss
	@Environment(\.modelContext) var modelContext

	@Query private var exercises: [Exercise]

	@FocusState var focus: TextFieldFocus?

	@State private var reps: Int = 0
	@State private var weight: Double = 0

	let repIncrements = 2
	let weightIncrements = 5.0

	var exercise: Exercise {
		exercises.first!
	}

	init(exerciseName: String) {
		let exerciseNameFilter = #Predicate<Exercise> { $0.name == exerciseName }

		_exercises = Query(filter: exerciseNameFilter)
	}

	var body: some View {
		Form {
			repsInput
			weightInput
		}
		.toolbar {
			ToolbarItem(placement: .cancellationAction) {
				Button("Cancel") {
					dismiss()
				}
				.tint(.red)
			}
			ToolbarItem(placement: .confirmationAction) {
				Button("Save") {
					save()
				}
			}
		}
	}
}

#Preview(traits: .modifier(ExerciseListModelPreviewModifier())) {
	@Previewable @Query var exerciseLists: [ExerciseList]

	NavigationStack {
		NewSetView(exerciseName: exerciseLists.first?.exercises.first?.name ?? "")
	}
	.modelContainer(ExerciseList.previewModel)
}

// Views
extension NewSetView {
	@ViewBuilder var repsInput: some View {
		Section {
			HStack {
				Button {
					guard reps >= repIncrements else { return }
					reps -= repIncrements
				} label: {
					Text("- \(repIncrements.formatted())")
				}
				.disabled(reps < repIncrements)
				.buttonStyle(.borderedProminent)
				.buttonStyle(.plain)
				Spacer()
				TextField("Reps", value: $reps, formatter: PFNumberFormatter.int)
					.focused($focus, equals: .reps)
					.multilineTextAlignment(.trailing)
					.textFieldStyle(.roundedBorder)
					.frame(width: 100)
				Text("reps")
					.padding(.trailing)
				Spacer()
				Button {
					reps += repIncrements
				} label: {
					Text("+ \(repIncrements.formatted())")
				}
				.buttonStyle(.borderedProminent)
				.buttonStyle(.plain)
			}
		}
	}

	@ViewBuilder var weightInput: some View {
		Section {
			HStack {
				Button {
					guard weight >= weightIncrements else { return }
					weight -= weightIncrements
				} label: {
					Text("- \(weightIncrements.formatted())")
				}
				.disabled(weight < weightIncrements)
				.buttonStyle(.borderedProminent)
				.buttonStyle(.plain)
				Spacer()
				TextField("Weight", value: $weight, formatter: PFNumberFormatter.decimal)
					.focused($focus, equals: .weight)
					.multilineTextAlignment(.trailing)
					.textFieldStyle(.roundedBorder)
					.frame(width: 100)
				Text("lbs")
					.padding(.trailing)
				Spacer()
				Button {
					weight += weightIncrements
				} label: {
					Text("+ \(weightIncrements.formatted())")
				}
				.buttonStyle(.borderedProminent)
				.buttonStyle(.plain)
			}
		}
	}
}

// Functions
extension NewSetView {
	func save() {
		let completedDate: Date = .now
		let newSet = ExerciseSet(
			reps: reps,
			weight: weight,
			dateCompleted: completedDate
		)

		// Add the set to the context
		modelContext.insert(newSet)
		// Add it to the exercises
		exercise.sets.append(newSet)

		for exerciseList in exercise.lists {
			exerciseList.lastCompletedDate = completedDate
		}

		do {
			try modelContext.save()
			dismiss()
		}
		catch {
			print("Error saving new set: \(error.localizedDescription)")
		}
	}
}