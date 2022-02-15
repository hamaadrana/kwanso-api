require 'spec_helper'

describe Blog do
  describe '#preview' do
    context "blog's body is less than 300 characters" do
      subject { create :blog, title: 'Exciting News', body: 'This is rather short.' }

      it "returns the blog's entire text" do
        expect(subject.preview).to eq('This is rather short.')
      end
    end

    context "blog's body is >25 characters and the 22nd character divides a word" do
      subject { create :blog, title: 'Exciting News', body: 'This blog is somewhat longer and "somewhat" will be split.' }

      it 'truncates the blog at the last word and appends ellipsis' do
        expect(subject.preview).to eq('This blog is...')
      end
    end

    context "blog's body is >25 characters and the 22nd character completes a word" do
      subject { create :blog, title: 'Exciting News', body: 'This blog is longer so it will end after "longer"' }

      it 'truncates the blog and appends ellipsis' do
        expect(subject.preview).to eq('This blog is longer...')
      end
    end

    context "blog's body is >25 characters and the 22nd character is a space after a word" do
      subject { create :blog, title: 'Exciting News', body: 'This blog is kinda long and will end at "kinda"' }

      it 'truncates the blog, removes the space, and appends ellipsis' do
        expect(subject.preview).to eq('This blog is kinda...')
      end
    end
  end
end