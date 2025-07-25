//
//  UIImage + Extensions.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 24.07.2025.
//
import UIKit
@preconcurrency import Vision

extension UIImage {
	
	func recognizeText(wordLimit: Int = 8, focusOnTop: Bool = true) async -> String {
		guard let cgImage = self.cgImage else {
			return "Без названия"
		}
		
		return await withCheckedContinuation { continuation in
			let request = VNRecognizeTextRequest { request, error in
				guard let observations = request.results as? [VNRecognizedTextObservation],
					  error == nil,
					  !observations.isEmpty else {
					continuation.resume(returning: "Без названия")
					return
				}
				
				let relevantObservations: ArraySlice<VNRecognizedTextObservation>
				
				if focusOnTop {
					let topObservations = observations.filter { observation in
						observation.boundingBox.origin.y > 0.7
					}
					relevantObservations = topObservations.isEmpty ? observations.prefix(5) : topObservations.prefix(3)
				} else {
					relevantObservations = observations.prefix(8)
				}
				
				let recognizedTexts = relevantObservations.compactMap { observation -> String? in
					guard let candidate = observation.topCandidates(1).first,
						  candidate.confidence > 0.6 else {
						return nil
					}
					
					let text = candidate.string.trimmingCharacters(in: .whitespacesAndNewlines)
					guard text.count > 2,
						  text.rangeOfCharacter(from: .letters) != nil else {
						return nil
					}
					
					return text
				}
				
				let combinedText = recognizedTexts.joined(separator: " ")
				let words = combinedText.components(separatedBy: .whitespacesAndNewlines)
					.filter { !$0.isEmpty }
				let titleWords = words.prefix(wordLimit)
				let finalTitle = titleWords.joined(separator: " ")
				
				continuation.resume(returning: finalTitle.isEmpty ? "Без названия" : finalTitle)
			}
			
			request.recognitionLevel = .accurate
			request.usesLanguageCorrection = true
			request.recognitionLanguages = ["ru", "en"]
			request.minimumTextHeight = 0.02
			
			let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
			
			DispatchQueue.global(qos: .userInitiated).async {
				do {
					try requestHandler.perform([request])
				} catch {
					print("OCR failed: \(error)")
					continuation.resume(returning: "Без названия")
				}
			}
		}
	}
	
	func recognizeTitle() async -> String {
		await recognizeText(wordLimit: 8, focusOnTop: true)
	}

	func recognizeFullText() async -> String {
		await recognizeText(wordLimit: 50, focusOnTop: false)
	}
}
