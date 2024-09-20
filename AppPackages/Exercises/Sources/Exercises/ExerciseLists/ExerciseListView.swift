//
// -----------------------------------------------------------
// Project: Exercises
// Created on 9/11/24 by @HeyJayWilson
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

public struct ExerciseListView: View {
	@Environment(\.modelContext) private var modelContext

	// Sorting by name here because I don't have an order field
	@Query(sort: \ExerciseList.name, order: .forward, animation: .default) private var lists:
		[ExerciseList]

	@State private var showNewListView: Bool = false

	public init() {}
	public var body: some View {
		NavigationStack {
			List {
				ForEach(lists) { exerciseList in
					NavigationLink(destination: ExerciseListDetailView(exerciseList: exerciseList)) {
						listRow(for: exerciseList)
					}
				}
				.onDelete(perform: deleteList)

				Section {
					NavigationLink("All Exercises") {
						AllExercisesListView()
					}
				}
			}
			.navigationTitle("My Lists")
			.toolbar {
				ToolbarItem {
					Button("Add list", systemImage: "plus.circle") {
						showNewListView = true
					}
				}
			}
			.sheet(isPresented: $showNewListView) {
				NewExerciseList()
			}
		}
	}
}

#Preview {
	ExerciseListView()
		.modelContainer(ExerciseList.previewModel)
}

extension ExerciseListView {
	@ViewBuilder func listRow(for exerciseList: ExerciseList) -> some View {
		HStack {
			Image(systemName: exerciseList.icon)
				.frame(maxWidth: 24)
			Text(exerciseList.name)
			Spacer()
			if let lastCompletedDate = exerciseList.lastCompletedDate {
				Text(
					lastCompletedDate,
					format: .relative(presentation: .named)
				)
			}
		}
	}
}

extension ExerciseListView {
	private func deleteList(at offsets: IndexSet) {
		var ids: [PersistentIdentifier] = []

		for index in offsets {
			let listToDelete = lists[index]
			ids.append(listToDelete.persistentModelID)
		}

		let container = modelContext.container
		let finalIDs = ids

		ids = []

		Task.detached(priority: .userInitiated) {
			let service = ExerciseList.Service(modelContainer: container)
			do {
				try await service.deleteList(for: finalIDs)
			}
			catch {
				print("🚨 \(#file) \(#function) \(error)")
			}
		}
	}
}