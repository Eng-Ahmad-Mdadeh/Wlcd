class SearchCourseData {
  const SearchCourseData({required this.title, required this.category, required this.price, required this.rating, required this.reviews, required this.level, required this.imageUrl});
  final String title;
  final String category;
  final double price;
  final double rating;
  final String reviews;
  final String level;
  final String imageUrl;
}

const searchCourses = [
  SearchCourseData(title: 'User Experience Design Essentials: Figma UI UX Design', category: 'UX Design', price: 89, rating: 4.8, reviews: '31,882', level: 'beginner', imageUrl: 'https://picsum.photos/seed/ux1/600/400'),
  SearchCourseData(title: 'Master Digital Product Design: UX Research & UI Design', category: 'UX Design', price: 69, rating: 4.5, reviews: '765', level: 'intermediate', imageUrl: 'https://picsum.photos/seed/ux2/600/400'),
  SearchCourseData(title: 'UX Design for Beginners: The Essential of UX', category: 'UX Design', price: 119, rating: 4.8, reviews: '386', level: 'beginner', imageUrl: 'https://picsum.photos/seed/ux3/600/400'),
];
