class MTHM
  require 'set'

  def define_t(_c, d, h, p, w, y)
    allowed_values = []
    p.each.with_index do |elem, u|
      next if u == 0
      if y[u] == 0 and w[u] <= _c[y[h]] + d
        allowed_values << {index: u, value: elem}
      end
    end
    max_p = allowed_values.max_by {|e| e[:value]}
    max_p[:index]
  end


# output: z, [y]
  def greedys(n, p, w, z, y, i, _c)
    (1..n).each do |j|
      if y[j] == 0 and w[j] <= _c[i]
        y[j] = i
        _c[i] = _c[i] - w[j]
        z = z + p[j]
      end
    end
    return z, y
  end

  def MTHM(n, m, p, w, c)
    # pp p
    p.unshift nil
    w.unshift nil
    c.unshift nil
    #  1. initialization
    z = 0
    y = Array.new(n+1, 0)
    _c = []
    c.count.times { |i| _c[i] = c[i] }
    (1..m).each do |i|
      # _c[i] = c[i]
      z, y = greedys(n, p, w, z, y, i, _c)
    end

    # 2. rearrangement
    z = 0
    (1..m).each { |i| _c[i] = c[i]}
    i = 1

    # ((n-1)..0).each do |j|
    (1..n).to_a.reverse.each do |j|
      if y[j] > 0
        allowed_indexes = Set.new
        (i..m).each { |index| allowed_indexes.add index }
        (1...i).each { |index| allowed_indexes.add index }
        l = nil
        allowed_indexes.each do |index|
          if w[j] <= _c[index]
            l = index
            break
          end
        end
        if l.nil?
          y[j] = 0
        else
          y[j] = l
          _c[l] = _c[l] - w[j]
          z = z + p[j]
          if l < m
            i = l + 1
          else
            i = 1
          end
        end

      end
    end
    (1..m).each do |i|
      z, y = greedys(n, p, w, z, y, i, _c)
    end

    # 3. first improvement
    (1..n).each do |j|
      if y[j] > 0
        ((j+1)..n).each do |k|
          if 0 < y[k] && y[k] != y[j]
            h = w[j] > w[k] ? j : k
            l = w[j] < w[k] ? j : k
            d = w[h] - w[l]
            wu = w.select.with_index do |elem, u|
              next if u == 0
              y[u] == 0
            end
            byebug
            if d <= _c[y[l]] and _c[y[h]] + d >= wu.min
              t = define_t(_c, d, h, p, w, y)
              _c[y[h]] = _c[y[h]] + d - w[t]
              _c[y[l]] = _c[y[l]] - d
              y[t] = y[h]
              y[h] = y[l]
              y[l] = y[t]
              z = z + p[t]
            end
          end
        end
      end
    end


    # 4. second improvement
    # ((n-1)..0).each do |j|

    (1..n).to_a.reverse.each do |j|
      if y[j] > 0
        __c = _c[y[j]] + w[j]
        y_upper = Set.new
        (1..n).each do |k|
          if y[k] == 0 and w[k] <= __c
            y_upper.add k
            __c = __c - w[k]
          end
        end
        sum_pk = 0
        y_upper.each { |k| sum_pk += p[k] }
        if sum_pk > p[j]
          y_upper.each { |k| y[k] = y[j] }
          _c[y[j]] = __c
          y[j] = 0
          z = z + sum_pk - p[j]
        end
      end
    end

    p 'y from MTHM.rb'
    pp y

    y.shift; c.shift
    # pp y, c, z

    y.map! { |elem| elem - 1 }

    return y, c, z
  end

end