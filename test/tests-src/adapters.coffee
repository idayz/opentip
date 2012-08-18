
$ = ender

adapters = [
  "native"
  "ender"
]

describe "Generic adapter", ->
  for adapterName in adapters
    describe "#{adapterName} adapter", ->

      it "should add itself to Opentip.adapters.#{adapterName}", ->
        expect(Opentip.adapters[adapterName]).to.be.ok()

      adapter = Opentip.adapters[adapterName]

      describe "domReady()", ->
        it "should call the callback", (done) ->
          adapter.domReady done

      describe "clone()", ->
        it "should create a shallow copy", ->
          obj =
            a: 1
            b: 2
            c:
              d: 3

          obj2 = adapter.clone obj

          expect(obj).to.not.equal obj2
          expect(obj).to.eql obj2
          obj2.a = 10
          expect(obj).to.not.eql obj2
          expect(obj.a).to.equal 1
          obj2.c.d = 30
          expect(obj.c.d).to.equal 30 # Shallow copy

      describe "extend()", ->
        it "should copy all attributes from sources to target", ->
          target =
            a: 1
            b: 2
            c: 3
          source1 =
            a: 10
            b: 20
          source2 =
            a: 100

          adapter.extend target, source1, source2
          expect(target).to.eql
            a: 100
            b: 20
            c: 3

